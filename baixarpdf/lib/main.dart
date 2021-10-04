import 'package:baixarpdf/screens/consulta_frete.dart';
import 'package:baixarpdf/screens/download_page.dart';
import 'package:baixarpdf/screens/home.dart';
import 'package:baixarpdf/screens/login.dart';
import 'package:baixarpdf/screens/novo_usuario.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

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
      routes: rotas,
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
    return LoginPage();
  }
}

Map<String, WidgetBuilder> get rotas {
  return <String, WidgetBuilder>{
    '/downalodpage': (BuildContext context) => new DownloadPage(),
    '/consultacep': (BuildContext context) => new ConsultaCep(),
    '/login': (BuildContext context) => new LoginPage(),
    '/home': (BuildContext context) => new HomePage(),
    '/novousuario': (BuildContext context) => new NovoUsuarioPage(),
  };
}
