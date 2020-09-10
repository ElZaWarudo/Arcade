import 'package:arcade/sauce/Vistas/Registro/register.dart';
import 'package:arcade/sauce/bloc/register/reg_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arcade/sauce/repository/User_repo.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepo _userRepo;

  RegisterScreen({Key key, @required UserRepo userRepo})
      :assert(userRepo != null),
        _userRepo = userRepo,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register'),),
      body: Center(
        child: BlocProvider<RegBloc>(
          create: (context) => RegBloc(userRepo: _userRepo),
          child: RegisterForm(),
        ),
      ),
    );
  }
}