import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadPage extends StatefulWidget {
  //const DownloadPage({Key key}) : super(key: key);

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  String porcentagemDownload = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download de Arquivos"),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 80,
          child: TextButton(
            style: TextButton.styleFrom(
                textStyle: const TextStyle(
              fontSize: 15,
            )),
            onPressed: () {
              baixarArquivo(context);
            },
            child: TextButton.icon(
              onPressed: () {
                baixarArquivo(context);
              },
              icon: Icon(Icons.analytics_outlined),
              label: Text('Baixar Arquivo 2021 $porcentagemDownload'),
            ),
          ),
        ),
      ),
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

  baixarArquivo(context) async {
    try {
      var url =
          "https://www.ifsudestemg.edu.br/editais/barbacena/estagio-remunerado/2019/estagio-remunerado-area-nutricao/edital-08_2019-nivel-superior.pdf";
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
