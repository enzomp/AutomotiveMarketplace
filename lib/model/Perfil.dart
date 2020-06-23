class Perfil {
  String _nome;
  String _cidade;
  String _telefone;
  String _foto;

  Perfil(this._nome, this._cidade, this._telefone, this._foto);

  String get email => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get foto => _foto;

  set foto(String value) {
    _foto = value;
  }


}