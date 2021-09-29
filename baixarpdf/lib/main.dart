import 'dart:io';
import 'package:baixarpdf/screens/consulta_frete.dart';
import 'package:baixarpdf/screens/download_page.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyApp._title,
      home: MyStatelessWidget(),
      routes: <String, WidgetBuilder>{
        '/downalodpage': (BuildContext context) => new DownloadPage(),
        '/consultacep': (BuildContext context) => new ConsultaCep(),
      },
    );
  }
}

class MyStatelessWidget extends StatefulWidget {
  const MyStatelessWidget({Key key}) : super(key: key);
  @override
  _MyStatelessWidgetState createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 5,
        child: ListView(children: <Widget>[
          SizedBox(
            height: 50,
          ),
          DrawerHeader(
            child: Image.network(
              "https://i.pinimg.com/736x/1f/eb/df/1febdf1846353dcb1cfbb679e0842d37.jpg",
            ),
          ),
          Divider(
            color: Colors.grey.shade600,
          ),
          ListTile(
            title: Text(
              "Download Arquivo",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blueAccent,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/downalodpage');
            },
          ),
          ListTile(
            title: Text(
              "Consultar Frete",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blueAccent,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/consultacep');
            },
          ),
        ]),
      ),
      appBar: AppBar(
        title: Text("Minhas Demos"),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Text("Bem Vindo!!"),
          );
        },
      ),
    );
  }
}
