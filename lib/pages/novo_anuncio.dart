import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NovoAnuncio extends StatefulWidget {
  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {

  File _foto;

  Future _getImage() async {
    PickedFile img;
    ImagePicker cam = ImagePicker();
    img = await cam.getImage(source: ImageSource.camera);

    setState(() {
      _foto = File(img.path);
    });
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
          Align(
            alignment: Alignment.topLeft,
            child: _addPhoto(context),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: _backBtn(context),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: _avatar,
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

  Widget _title(){
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

  Widget _action(){
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
        onPressed: () {},
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
                hintText: 'Espécie',
              ),
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
                hintText: 'Raça',
              ),
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
                hintText: 'Idade',
              ),
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }
}
