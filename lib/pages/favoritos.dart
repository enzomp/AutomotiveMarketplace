import 'package:flutter/material.dart';
import 'package:com/components/menu_inferior.dart';

class MeusFavoritos extends StatefulWidget {
  @override
  _MeusFavoritosState createState() => _MeusFavoritosState();
}

class _MeusFavoritosState extends State<MeusFavoritos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Meus Favoritos'),
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
        //child: _body(),
      ),


      bottomNavigationBar: MenuInferior(),
    );
  }
}

