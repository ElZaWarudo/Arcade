import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;

  LoginButton({Key key, VoidCallback onPressed})
  :_onPressed = onPressed,
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Log In'),
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: _onPressed,
    );
  }
}
