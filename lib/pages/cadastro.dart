import 'package:flutter/material.dart';
import 'package:com/pages/home.dart';

class Cadastro extends StatelessWidget {

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          )
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 80, left: 30, right: 30),
              child:
                Image.asset(
                  "assets/images/logo.png"
                ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 40, left: 30, right: 30),
              child: TextField(
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
                  hintText: 'Nome Completo',
                ),
                controller: _nomeController,
                keyboardType: TextInputType.text,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10, left: 30, right: 30),
              child: TextField(
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
                  hintText: 'E-mail',
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10, left: 30, right: 30),
              child: TextField(
                obscureText: true,
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
                  hintText: 'Senha',
                ),
                controller: _senhaController,
                keyboardType: TextInputType.text,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 150,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white),
                      ),
                      child: Text(
                        'CADASTRAR',
                        style: TextStyle(fontFamily: 'Oswald', color: Colors.white),
                      ),
                      color: Colors.amber,
                      onPressed: () {
                        print(
                          _nomeController.text + " - " +
                          _emailController.text + " - " +
                          _senhaController.text
                        );
                      },
                    ),
                  ),

                  Container(
                    width: 150,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)
                      ),
                      child: Text(
                        'VOLTAR',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      )
    );
  }
}
