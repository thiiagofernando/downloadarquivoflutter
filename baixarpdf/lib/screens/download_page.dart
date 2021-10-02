import 'dart:io';

import 'package:baixarpdf/models/foto_model.dart.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key key}) : super(key: key);

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  String porcentagemDownload = "";
  bool temFotoNova = false;
  bool processando = false;
  String urlFoto = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visualizador de Gatinhos"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              visualizarFoto(),
              botoesBuscarBaixar(),
            ],
          ),
        ),
      ),
    );
  }

  visualizarFoto() {
    if (temFotoNova) {
      return Container(
        alignment: Alignment.center, // use aligment
        child: Image.network(
          urlFoto,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return SizedBox(
        height: 3,
      );
    }
  }

  botoesBuscarBaixar() {
    return Column(
      children: [
        Row(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                buscarFoto();
              },
              child: TextButton.icon(
                onPressed: () {
                  buscarFoto();
                },
                icon: Icon(Icons.search),
                label: Text(
                  'Buscar Nova Foto',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                baixarArquivo();
              },
              child: TextButton.icon(
                onPressed: () {
                  baixarArquivo();
                },
                icon: Icon(Icons.analytics_outlined),
                label: Text(
                  'Baixar Foto',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        exibirProcessando(),
      ],
    );
  }

  showDownloadProgress(received, total) {
    if (total != -1) {
      setState(
        () {
          porcentagemDownload =
              "\n" + (received / total * 100).toStringAsFixed(0) + "%";
          if ((received / total * 100) == 100) {
            porcentagemDownload = "\n Downaload realizado";
          }
        },
      );
    }
  }

  exibirProcessando() {
    if (processando) {
      return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              "Processando..",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              porcentagemDownload,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }

  buscarFoto() async {
    setState(() {
      processando = true;
    });
    Dio dio = Dio();
    Response response = await dio.get(
      "https://api.thecatapi.com/v1/images/search",
    );
    var foto = Foto.fromJson(response.data[0]);
    setState(() {
      urlFoto = foto.url;
      temFotoNova = true;
      processando = false;
      porcentagemDownload = "";
    });
  }

  baixarArquivo() async {
    try {
      setState(() {
        processando = true;
      });
      var url = urlFoto;
      Dio dio = Dio();
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );

      var dir = await obterCaminhoDispositivo();

      String fileName = url.substring(url.lastIndexOf("/") + 1);
      var date = '${DateTime.now().microsecond}_';
      var savePath = "$dir/$date$fileName";
      print(savePath);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      setState(() {
        porcentagemDownload = "\n Falha no Downaload";
      });
    }
    setState(() {
      porcentagemDownload = "";
      processando = false;
    });
  }

  Future<String> obterCaminhoDispositivo() async {
    String caminho = "";
    if (Platform.isAndroid) {
      caminho = "/sdcard/download";
    } else {
      caminho = (await getApplicationDocumentsDirectory()).path;
    }
    return caminho;
  }
}
