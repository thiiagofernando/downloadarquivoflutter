import 'package:baixarpdf/database/database_helper.dart';
import 'package:baixarpdf/models/usuario_model.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final ctrlLogin = TextEditingController();
    final ctrlSenha = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Container(
                height: 150.0,
                width: 190.0,
                padding: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Center(
                  child: Image.asset('assets/images/logologin.png'),
                ),
              ),
              SizedBox(
                height: 30,
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
                  final valida = await validarLogin(
                      login: ctrlLogin.text, senha: ctrlSenha.text);
                  if (valida.login.length > 0) {
                    Navigator.of(context).pushNamed('/home');
                  } else {
                    final snackBar = SnackBar(
                      content: const Text('Usuário não encontrado'),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text(
                  'Entrar',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/novousuario');
                },
                child: Text(
                  'Não possui uma conta?, clique e crie a sua conta',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<UsuarioModel> validarLogin({
    @required String login,
    @required String senha,
  }) async {
    try {
      if (login.length < 1 || senha.length < 1) {
        final snackBar = SnackBar(
          content: const Text('Informe Login e a Senha'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return UsuarioModel();
      } else {
        final logar = await DataBaseHelper.instance.loginUsuario(login, senha);
        return logar;
      }
    } catch (e) {
      return e;
    }
  }
}
