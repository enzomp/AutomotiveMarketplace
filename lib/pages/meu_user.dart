import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:com/components/menu_inferior.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyUser extends StatefulWidget {
  @override
  _MyUserState createState() => _MyUserState();
}

class _MyUserState extends State<MyUser>
  with SingleTickerProviderStateMixin {

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();

  Firestore db = Firestore.instance;
  String _userID = "";
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

  Future _getUser() async{
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    setState(() {
      _userID = currentUser.uid;
    });
  }

  _validacao() {
    String nome = _nomeController.text;
    String cidade = _cidadeController.text;
    String telefone = _telefoneController.text;

    if (nome.isNotEmpty && cidade.isNotEmpty && telefone.isNotEmpty) {
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
    String cidade = _cidadeController.text;
    String telefone = _telefoneController.text;

    FirebaseUser user;

    String link_foto = "";

    await FirebaseAuth.instance.currentUser().then((currentUser) => {
      if (currentUser != null) {
        user = currentUser,
      }
    });

    await Firestore.instance.collection("perfil").document(_userID).updateData({
        "nome" : nome,
        "cidade" : cidade,
        "telefone" : telefone,
        "foto"  : "",
        });


    if(_foto != "") {
      FirebaseStorage storage = FirebaseStorage.instance;
      StorageReference rootFolder = storage.ref();
      StorageReference arquivo = rootFolder.child("perfil_img").child(user.uid);
      arquivo.putFile(_foto);

      StorageUploadTask task = arquivo.putFile(_foto);
      await task.onComplete.then((StorageTaskSnapshot snapshot) async {
        link_foto = await snapshot.ref.getDownloadURL();
      });

      await Firestore.instance.collection("perfil").document(_userID).updateData({
        'foto' : link_foto
      });

    }
  }

  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  _loadBody() {
    return _userID == ""
        ? Center(
      child: Column(
        children: <Widget>[
          Text("Carregando perfil..."),
          CircularProgressIndicator()
        ],
      ),
    )
        :_body();
  }

  _body() {
    return StreamBuilder(
      stream: Firestore.instance.collection("perfil").document(_userID).snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none :
          case ConnectionState.done :
          case ConnectionState.waiting :
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Carregando perfil..."),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;

          case ConnectionState.active :
            DocumentSnapshot documentSnapshot = snapshot.data;

            if (snapshot.hasError) {
              return Container(
                child: Text("Ocorreram erros ao carregar os dados"),
              );
            }

            else {
              print("DADOS CARREGADOS: " + snapshot.data.toString());

            var perfil = snapshot.data;

              return Container(
                    child: Column(
                      children: <Widget>[
                        new Container(
                          height: 250.0,
                          color: Colors.white,
                          child: new Column(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                                  child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 25.0),
                                        child: new Text('Meu Perfil',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30.0,
                                                fontFamily: 'Oswald',
                                                color: Colors.black)),
                                      )
                                    ],
                                  )),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: new Stack(fit: StackFit.loose, children: <Widget>[
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                          width: 140.0,
                                          height: 140.0,
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                              image: NetworkImage(perfil["foto"]),
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(top: 90.0, right: 100.0),
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            radius: 25.0,
                                            child: new IconButton(
                                              icon: Icon(Icons.camera_alt),
                                              color: Colors.black,
                                              onPressed: _getImage,
                                            ),
                                          )
                                        ],
                                      )),
                                ]),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 25.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Minhas informações',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Oswald'),
                                            ),
                                          ],
                                        ),
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            _status ? _getEditIcon() : new Container(),
                                          ],
                                        )
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Nome',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Oswald'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextField(
                                            decoration: InputDecoration(
                                              hintText: perfil["nome"],
                                            ),
                                            enabled: !_status,
                                            autofocus: !_status,
                                            controller: _nomeController,
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Cidade',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Oswald'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextField(
                                            decoration: InputDecoration(
                                                hintText: perfil["cidade"]),
                                            enabled: !_status,
                                            controller: _cidadeController,
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Telefone',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Oswald'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextField(
                                            decoration: InputDecoration(
                                                hintText: perfil["telefone"]),
                                            enabled: !_status,
                                            controller: _telefoneController,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                      ],
                                    )),
                                !_status ? _getActionButtons() : new Container(),
                              ],
                            ),
                          ),
                        )
                      ],
                   )
              );
            }
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: MenuInferior(),
        body: new Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/homeBackground.png"),
                fit: BoxFit.cover,
              )
          ),
           child: _loadBody(),
        )
       );
    }

    @override
    void dispose() {
      myFocusNode.dispose();
      super.dispose();
    }

    Widget _getActionButtons() {
      return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Container(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.amber)
                    ),
                    child: Text('SALVAR',
                      style: TextStyle(
                          fontFamily: 'Oswald',
                          color: Colors.white
                      ),
                    ),
                    color: Colors.amber,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                      _validacao();
                    },
                  ),
                ),
              ),
              flex: 2,
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Container(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black)
                    ),
                    child: Text('Cancelar',
                      style: TextStyle(
                          fontFamily: 'Oswald',
                          color: Colors.black
                      ),
                    ),
                    //color: Colors.grey,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                  ),
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      );
    }

    Widget _getEditIcon() {
      return new GestureDetector(
        child: new CircleAvatar(
          backgroundColor: Colors.amber,
          radius: 14.0,
          child: new Icon(
            Icons.edit,
            color: Colors.black,
            size: 16.0,
          ),
        ),
        onTap: () {
          setState(() {
            _status = false;
          });
        },
      );
    }
  }
