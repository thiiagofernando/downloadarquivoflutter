import 'package:baixarpdf/database/database_helper.dart';
import 'package:baixarpdf/models/usuario_model.dart';
import 'package:baixarpdf/screens/menu-lateral.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(
        title: Text("Minhas Demos"),
      ),
      body: Center(
        child: FutureBuilder<List<UsuarioModel>>(
          future: DataBaseHelper.instance.obterListaDeUsuario(),
          builder: (BuildContext context,
              AsyncSnapshot<List<UsuarioModel>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("Carregando....."),
              );
            }
            return ListView(
              children: snapshot.data.map((e) {
                return Center(
                  child: ListTile(
                    title: Text(e.nome),
                    subtitle: Text(e.login),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
