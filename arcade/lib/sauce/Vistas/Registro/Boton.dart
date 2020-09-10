import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  RegisterButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Crear cuenta'),
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: _onPressed,
    );
  }
}