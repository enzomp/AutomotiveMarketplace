import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NovoAnuncio extends StatefulWidget {
  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _precoController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  String _erroMsg = "";
  File _foto;

  Future _getImage() async {
    PickedFile img;
    ImagePicker cam = ImagePicker();
    img = await cam.getImage(source: ImageSource.camera);

    setState(() {
      _foto = File(img.path);
    });
  }

  _validacao() {
    String nome = _nomeController.text;
    String preco = _precoController.text;
    String telefone = _telefoneController.text;

    if (nome.isNotEmpty && preco.isNotEmpty && telefone.isNotEmpty) {
      _cadastrar();
    }
    else {
      setState(() {
        _erroMsg = "Preencha todos os campos";
      });
    }
  }

  Future _cadastrar() async {
    String nome = _nomeController.text;
    String preco = _precoController.text;
    String telefone = _telefoneController.text;

    String new_anuncio;
    FirebaseUser user;

    String link_foto = "";

    await FirebaseAuth.instance.currentUser().then((currentUser) => {
      if (currentUser != null) {
        user = currentUser,
      }
    });

    await Firestore.instance
      .collection(user.uid)
      .document("anuncios")
      .collection("anuncios")
      .add({
        "nome" : nome,
        "preco" : preco,
        "telefone" : telefone,
        "foto"  : "",
    }).then((value){
      new_anuncio = value.documentID;
    });

    if(_foto != "") {
      FirebaseStorage storage = FirebaseStorage.instance;
      StorageReference rootFolder = storage.ref();
      StorageReference arquivo = rootFolder.child("anuncios_img").child(user.uid).child(new_anuncio);
      arquivo.putFile(_foto);

      StorageUploadTask task = arquivo.putFile(_foto);
      await task.onComplete.then((StorageTaskSnapshot snapshot) async {
        link_foto = await snapshot.ref.getDownloadURL();
      });

      await Firestore.instance
        .collection(user.uid)
        .document("anuncios")
        .collection("anuncios")
        .document(new_anuncio)
        .updateData({
          'foto' : link_foto
        });
    }

    print("ID DOC: "+ new_anuncio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: _image(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: _avatar(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: _addPhoto(context),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: _backBtn(context),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _title(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _content(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _action(),
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return Container(
      color: Colors.amber,
      height: 600,
    );
  }

  Widget _avatar() {
    return _foto == null
        ? Container()
        : Padding(
      padding: EdgeInsets.only(top: 225, left: 150, right: 30),
      child: CircleAvatar(
        radius: 55,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(_foto.path),
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      height: 450,
      width: 510,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Text(
          "Criar Anúncio",
          textAlign: TextAlign.center,

          style: TextStyle(
            fontFamily: 'Oswald',
            fontSize: 25,
            color: Colors.white),
          )
    );
  }

  Widget _action() {
    return Container(
      width: 200,
      height: 45,
      margin: EdgeInsets.only(bottom: 45),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.amber)
        ),
        child: Text('ADICIONAR',
          style: TextStyle(
              fontFamily: 'Oswald',
              color: Colors.white
          ),
        ),
        color: Colors.amber,
        onPressed: () {
          _validacao();
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _addPhoto(BuildContext context) {
    return Container(
      height: 60,
      width: 330,
      margin: EdgeInsets.only(
        left: 40,
        top: 100,
      ),
      child: RaisedButton(
        color: Colors.transparent,
        onPressed: () {
          _getImage();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 70),
              child: Icon(
                Icons.camera_enhance,
                color: Colors.amber,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Clique para adicionar nova foto.",
                style: TextStyle(
                    fontFamily: 'Oswald',
                    color: Colors.white.withOpacity(0.5)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backBtn(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      margin: EdgeInsets.only(
        left: 40,
        top: 100,
      ),
      child: RaisedButton(
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Icon(
          Icons.arrow_back,
          color: Colors.amber,
        ),
      ),
    );
  }

  Widget _content() {
    return Container(
      height: 410,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, left: 30, right: 30),
            child:
            TextField(
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(50.0),
                  ),
                ),
                contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),

                filled: true,
                fillColor: Colors.white,

                alignLabelWithHint: true,
                hintText: 'Nome',
              ),
              controller: _nomeController,
              keyboardType: TextInputType.text,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 20, left: 30, right: 30),
            child:
            TextField(
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(50.0),
                  ),
                ),
                contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),

                filled: true,
                fillColor: Colors.white,

                alignLabelWithHint: true,
                hintText: 'Preço',
              ),
              controller: _precoController,
              keyboardType: TextInputType.text,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 20, left: 30, right: 30),
            child:
            TextField(
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(50.0),
                  ),
                ),
                contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),

                filled: true,
                fillColor: Colors.white,

                alignLabelWithHint: true,
                hintText: 'Telefone',
              ),
              controller: _telefoneController,
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }
}
