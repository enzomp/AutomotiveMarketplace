import 'package:com/pages/meu_user.dart';
import 'package:com/pages/meus_anuncios.dart';
import 'package:flutter/material.dart';
import 'package:com/pages/home.dart';

class MenuInferior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      //shape: const CircularNotchedRectangle(),
      child: Container(
        height: 50.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home, color: Colors.amber),
              tooltip: 'Home',
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),

            IconButton(
              icon: const Icon(Icons.star, color: Colors.amber),
              tooltip: 'Favoritos',
              onPressed: () {/* **/},
            ),

            IconButton(
              icon: const Icon(Icons.list, color: Colors.amber),
              tooltip: 'Meus Anúncios',
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => MeusAnuncios()),
                );
              },
            ),

            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.amber),
              tooltip: 'Meu Perfil',
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyUser()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}