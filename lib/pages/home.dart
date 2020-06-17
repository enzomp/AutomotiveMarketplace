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
  String user;

  String _getUser() {
    FirebaseAuth.instance.currentUser().then((currentUser) => {
      if (currentUser != "") {
        user = currentUser.uid,
      }
    });
    print("USER:: "+user);
    return user;
  }


  _body() {
    return StreamBuilder(
      stream: db.collection( _getUser() ).document("anuncios").collection("anuncios").snapshots(),
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
                        List<DocumentSnapshot> anuncios = querySnapshot
                            .documents.toList();
                        DocumentSnapshot dados = anuncios[index];

                        Anuncios anuncio = Anuncios(
                            dados["nome"], dados["preco"], dados["telefone"],
                            dados["foto"]);

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(anuncio.foto),
                          ),
                          title: Text(anuncio.nome),
                          subtitle: Text(
                              "Preço: " + anuncio.preco + " Telefone: " +
                                  anuncio.telefone),
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
                fit: BoxFit.cover
            )
        ),
        child: _body(),
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
