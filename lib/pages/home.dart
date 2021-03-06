import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com/components/menu_inferior.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:com/model/Anuncios.dart';
import 'package:com/pages/novo_anuncio.dart';


class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Firestore db = Firestore.instance;
  String _userID = "";

  Future _getUser() async{
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    setState(() {
      _userID = currentUser.uid;
    });
  }

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
                Text("Carregando anúncios..."),
                CircularProgressIndicator()
              ],
            ),
          )
        :_body();
  }


  _body() {
    return StreamBuilder(
      stream: db.collection("anuncios").snapshots(),
      //ignore: missing return
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none :
          case ConnectionState.done:
          case ConnectionState.waiting :
            return Center(
                child: Column(
                  children: <Widget>[
                    Text("Carregando anúncios..."),
                    CircularProgressIndicator()
                  ],
                )
            );
            break;
          case ConnectionState.active :
            QuerySnapshot querySnapshot = snapshot.data;

            if (snapshot.hasError) {
              return Container(
                child: Text("Ocorreram erros ao carregar os dados."),
              );
            }

            else {
              print("DADOS CARREGADOS: " + snapshot.data.toString());

              return Container(
                  child: ListView.builder(
                      itemCount: querySnapshot.documents.length,
                      itemBuilder: (context, index) {
                        List<DocumentSnapshot> anuncios = querySnapshot.documents.toList();
                        DocumentSnapshot dados = anuncios[index];

                        Anuncios anuncio = Anuncios(
                            dados["nome"], dados["preco"], dados["telefone"],
                            dados["foto"]);


                        return Card(
                          elevation: 3,
                            child: Container(
                              height: 100.0,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      topLeft: Radius.circular(5)
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(anuncio.foto)
                                      )
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 236,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                         child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(anuncio.nome, style: TextStyle(
                                              fontSize: 20,
                                            ),),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                              child: Container(
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.amber),
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                                ),
                                                child: Text(anuncio.preco, textAlign: TextAlign.center,),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                              child: Container(
                                                width: 260,
                                                child: Text("Telefone: " + anuncio.telefone, style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(255, 48, 48, 54)
                                                  ),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  Container(
                                      child: Padding(
                                        padding: EdgeInsets.all(0),
                                        child: FavoriteWidget()
                                      )
                                    )
                                  ]
                                ),
                              ),
                            );
                          }
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Anúncios'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),

      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/homeBackground.png"),
                fit: BoxFit.cover,
            )
        ),
        child: _loadBody(),
      ),


      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => NovoAnuncio()
              )
          );
        },
        tooltip: 'Novo Anúncio',
        backgroundColor: Colors.amber,
      ),

      bottomNavigationBar: MenuInferior(),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.amber,
            onPressed: _toggleFavorite,
          ),
        ),
      ],
    );
  }

  void _toggleFavorite() {
    List<DocumentSnapshot> favoritos = [];
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }
}


