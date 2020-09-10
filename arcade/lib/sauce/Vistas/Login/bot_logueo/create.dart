import 'package:arcade/sauce/Vistas/Registro/register_screen.dart';
import 'package:arcade/sauce/repository/User_repo.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatelessWidget {
  final UserRepo _userRepo;

  CreateAccount({Key key, @required UserRepo userRepo})
    :assert(userRepo!=null),
    _userRepo=userRepo,
    super(key:key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Crea tu cuenta'),
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context){
            return RegisterScreen(userRepo: _userRepo);
          })
        );
      }
    );
  }
}
