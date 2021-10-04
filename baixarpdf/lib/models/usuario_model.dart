class UsuarioModel {
  int id;
  String nome;
  String login;
  String senha;
  bool ativo;

  UsuarioModel({this.id, this.nome, this.login, this.senha, this.ativo});

  factory UsuarioModel.fromMap(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'],
      nome: json['nome'],
      login: json['login'],
      senha: json['senha'],
      ativo: json['ativo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'login': login,
      'senha': senha,
      'ativo': ativo,
    };
  }
}
