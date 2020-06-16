import 'package:flutter/material.dart';

class NovoAnuncio extends StatelessWidget{
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
            child: _content(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _action(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: _backBtn(context),
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