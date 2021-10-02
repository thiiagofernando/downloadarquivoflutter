import 'package:baixarpdf/models/retorno_viacep.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ConsultaCep extends StatefulWidget {
  const ConsultaCep({Key key}) : super(key: key);

  @override
  _ConsultaCepState createState() => _ConsultaCepState();
}

class _ConsultaCepState extends State<ConsultaCep> {
  var _controllerCep = TextEditingController();
  bool _isDisable = true;
  String textoValor = "";
  @override
  Widget build(BuildContext context) {
    ativarBotao(_controllerCep.text);
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulta Frete"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (valor) {
                ativarBotao(valor);
              },
              controller: _controllerCep,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 8,
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: _isDisable ? null : buscarCep,
              child: Text("Consultar CEP"),
            ),
            SizedBox(
              height: 60,
            ),
            Center(
              child: Text(
                textoValor,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  buscarCep() async {
    try {
      var url = "https://viacep.com.br/ws/${_controllerCep.text}/json/";
      Dio dio = Dio();
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        var retorno = RetornoViaCep.fromJson(response.data);
        calcularFrete(uf: retorno.uf, cidade: retorno.localidade);
      }
    } catch (e) {
      setState(() {
        textoValor = "\n Falha no Calculo";
      });
    }
  }

  void ativarBotao(String valor) {
    if (valor.length == 0) {
      setState(() {
        this._isDisable = true;
      });
    }
    if (valor.length > 0) {
      setState(() {
        this._isDisable = false;
      });
    }
  }

  calcularFrete({String uf, String cidade}) {
    String estado = "MT";
    String localidade = "Várzea Grande";
    if (uf == estado && cidade == localidade) {
      setState(() {
        textoValor = "Cidade\n$cidade \nValor é R\$ 10.00";
      });
    }
    if (uf == estado && cidade != localidade) {
      setState(() {
        textoValor = "Cidade\n$cidade \nValor é R\$ 20.00";
      });
    }
    if (uf != estado && cidade != localidade) {
      setState(() {
        textoValor = "Cidade\n$cidade \nValor é R\$ 40.00";
      });
    }
  }
}
