import 'package:baixarpdf/database/database_helper.dart';
import 'package:baixarpdf/models/usuario_model.dart';
import 'package:flutter/material.dart';

class NovoUsuarioPage extends StatefulWidget {
  const NovoUsuarioPage({Key key}) : super(key: key);

  @override
  _NovoUsuarioPageState createState() => _NovoUsuarioPageState();
}

class _NovoUsuarioPageState extends State<NovoUsuarioPage> {
  final ctrlLogin = TextEditingController();
  final ctrlSenha = TextEditingController();
  final ctrlNomeCompleto = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("Crie Seu Usuário"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
              height: 150.0,
              width: 190.0,
              padding: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
              ),
              child: Center(
                child: Image.asset('assets/images/novoUsuario.png'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: ctrlNomeCompleto,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                  hintText: 'Informe o seu nome completo',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: ctrlLogin,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Login',
                  hintText: 'Informe o um login válido',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: ctrlSenha,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                  hintText: 'Informe sua senha!',
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                var criar = await criarNovoUsuario();
                if (criar > 0) {
                  Navigator.of(context).pushNamed('/login');
                } else {
                  final snackBar = SnackBar(
                    content: const Text('Falha ao criar usuário'),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {},
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text(
                'Salvar',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<int> criarNovoUsuario() async {
    try {
      if (ctrlNomeCompleto.text.length > 0 &&
          ctrlLogin.text.length > 0 &&
          ctrlSenha.text.length > 0) {
        return await DataBaseHelper.instance.inserirNovoUsuario(
          UsuarioModel(
            nome: ctrlNomeCompleto.text,
            login: ctrlSenha.text,
            senha: ctrlSenha.text,
            ativo: true,
            id: 0,
          ),
        );
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }
}
