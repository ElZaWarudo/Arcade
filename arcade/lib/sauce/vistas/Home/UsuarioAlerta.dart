import 'package:flutter/material.dart';

class UsuarioAlerta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Ingresa tu nombre de usuario, así seras visto en las tablas de puntuaciones"),
      content: Form(
        child: TextFormField(

        ),
      ),
      actions: <Widget>[
        RaisedButton(
          child: Text("¡Vamos!"),
          onPressed: (){

          },
        )
      ],
    );
  }
}
