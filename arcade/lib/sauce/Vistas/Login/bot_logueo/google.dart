import 'package:arcade/sauce/bloc/autenticacion/aut_event.dart';
import 'package:arcade/sauce/bloc/login/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.redAccent,
      textColor: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.google),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text('Log In con Google'),
          ),
        ],
      ),
      onPressed: () {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Ingresando...'),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithGooglePressed()
        );
      },
    );
  }
}
