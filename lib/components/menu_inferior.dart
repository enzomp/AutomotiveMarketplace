import 'package:flutter/material.dart';

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
              onPressed: () {/* **/},
            ),

            IconButton(
              icon: const Icon(Icons.star, color: Colors.amber),
              tooltip: 'Favoritos',
              onPressed: () {/* **/},
            ),

            IconButton(
              icon: const Icon(Icons.list, color: Colors.amber),
              tooltip: 'Meus Anúncios',
              onPressed: () {/* **/},
            ),

            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.amber),
              tooltip: 'Meu Perfil',
              onPressed: () {/* **/},
            )
          ],
        ),
      ),
    );
  }
}