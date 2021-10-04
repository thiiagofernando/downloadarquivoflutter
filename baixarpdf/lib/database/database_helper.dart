import 'package:baixarpdf/models/usuario_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

class DataBaseHelper {
  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();
  static Database _database;
  Future<Database> get database async => _database = await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    var comandos = StringBuffer();
    final SqlUsuario =
        "CREATE table usuarios(id INTEGER PRIMARY KEY AUTOINCREMENT,nome text UNIQUE,login text UNIQUE,senha text,ativo BOOLEAN NOT NULL);";
    comandos.write(SqlUsuario);
    comandos.write("");
    final SqlTarefas =
        "CREATE table tarefas(id INTEGER PRIMARY KEY AUTOINCREMENT,nome text UNIQUE,descricao text ,realizada BOOLEAN NOT NULL);";
    comandos.write("");
    comandos.write(SqlTarefas);
    await db.execute(comandos.toString());
  }

  Future<List<UsuarioModel>> obterListaDeUsuario() async {
    Database db = await instance.database;
    var usuarios = await db.query('usuarios', orderBy: 'nome');
    var usuarioLista = usuarios.isNotEmpty
        ? usuarios.map((e) => UsuarioModel.fromMap(e)).toList()
        : [];
    return usuarioLista;
  }

  Future loginUsuario(String loginUsuario, String senhaUsuario) async {
    Database db = await instance.database;
    var verificarUsuario = await db.query('usuarios', orderBy: 'nome');
    //await db.rawQuery(
    // 'select * from usuarios where login ="$loginUsuario" and senha ="$senhaUsuario"');
    var usuarioLogado = verificarUsuario.isNotEmpty
        ? verificarUsuario.map((e) => UsuarioModel.fromMap(e)).toList()
        : [];
    var fe = usuarioLogado.single;
    return UsuarioModel();
  }

  Future<int> inserirNovoUsuario(UsuarioModel novoUsuario) async {
    Database db = await instance.database;
    return await db.rawInsert(
        'insert into usuarios(nome,login,senha,ativo) values("${novoUsuario.nome}","${novoUsuario.login}","${novoUsuario.senha}","true")');
  }
}
