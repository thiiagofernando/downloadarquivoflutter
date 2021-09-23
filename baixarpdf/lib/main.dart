import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  static const String _title = 'Baixar Arquivo';
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyApp._title,
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatefulWidget {
  const MyStatelessWidget({Key key}) : super(key: key);
  @override
  _MyStatelessWidgetState createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  String porcentagemDownload = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 5,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            DrawerHeader(
              child: null,
              decoration: BoxDecoration(
                color: Colors.lightBlue[900],
                shape: BoxShape.circle,
              ),
            ),
            Divider(
              color: Colors.grey.shade600,
            ),
            ListTile(
              title: Text(
                "Nome do Menu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blueAccent,
                ),
              ),
              onTap: () {
                print("Clicou no menu");
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Baixar de Arquivo"),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: 300,
              height: 80,
              child: TextButton.icon(
                icon: Icon(Icons.analytics_outlined),
                label: Text('Baixar Arquivo 2021 $porcentagemDownload'),
                onPressed: () {
                  baixarArquivo(context);
                },
              ),
            ),
          );
        },
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
