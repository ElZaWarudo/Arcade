import 'package:arcade/sauce/bloc/login/bloc.dart';
import 'package:arcade/sauce/repository/User_Repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepo _userRepo;

  LoginScreen({Key key, @required UserRepo userRepo})
      : assert(userRepo != null),
        _userRepo = userRepo,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepo: _userRepo),
        child: LoginForm(userRepo: _userRepo),
      ),
    );
  }
}