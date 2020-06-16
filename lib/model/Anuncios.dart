class Anuncios{
  String _nome;
  String _preco;
  String _telefone;
  String _foto;


  Anuncios(this._nome, this._preco, this._telefone, this._foto);

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get preco => _preco;

  String get foto => _foto;

  set foto(String value) {
    _foto = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  set preco(String value) {
    _preco = value;
  }

}