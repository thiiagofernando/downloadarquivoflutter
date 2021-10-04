import 'package:flutter/material.dart';

class MenuLateral extends StatefulWidget {
  const MenuLateral({Key key}) : super(key: key);

  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: ListView(children: <Widget>[
        SizedBox(
          height: 50,
        ),
        DrawerHeader(
          child: Image.asset(
            'assets/images/foto001.jpg',
          ),
        ),
        Divider(
          color: Colors.grey.shade600,
        ),
        ListTile(
          title: Text(
            "Fotos Gatinhos",
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
        ListTile(
          title: Text(
            "Sair",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blueAccent,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed('/login');
          },
        ),
      ]),
    );
  }
}
