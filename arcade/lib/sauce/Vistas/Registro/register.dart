import 'package:arcade/sauce/Vistas/Registro/Boton.dart';
import 'package:arcade/sauce/bloc/autenticacion/bloc.dart';
import 'package:arcade/sauce/bloc/register/bloc.dart';
import 'package:arcade/sauce/bloc/register/reg_state.dart';
import 'package:arcade/sauce/bloc/register/reg_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // Dos variables
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  RegBloc _regBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _regBloc = BlocProvider.of<RegBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegBloc, RegState>(
        listener: (context, state) {
          // Si estado es submitting
          if (state.isSubmitting) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Registrando...'),
                        CircularProgressIndicator()
                      ],
                    ),
                  )
              );
          }
          // Si estado es success
          if (state.isSuccess) {
            BlocProvider.of<AutBloc>(context)
                .add(LoggedIn());
            Navigator.of(context).pop();
          }
          // Si estado es failure
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Fallo al registrar'),
                        Icon(Icons.error)
                      ],
                    ),
                    backgroundColor: Colors.red,
                  )
              );
          }
        },
        child: BlocBuilder<RegBloc, RegState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                child: ListView(
                  children: [
                    Padding (
                      padding: const EdgeInsets.only(top: 30),
                      child: Text('Crea tu cuenta',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.deepPurple,fontFamily: 'Audiowide'),
                      ),
                    ),
                    Padding (
                      padding: const EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(hintText: "Correo Electronico"),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        autovalidate: true,
                        validator: (_){
                          return !state.isEmailValid? 'Invalid Email' : null;
                        },
                      ),
                    ),
                    Padding (
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(hintText: "Contraseña"),
                        obscureText: true,
                        autocorrect: false,
                        autovalidate: true,
                        validator: (_){
                          return !state.isPasswordValid ? 'Contraseña invalida': null;
                        },
                      ),
                    ),
                    Padding (
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: _passwordController2,
                        decoration: InputDecoration(hintText: "Repetir contraseña"),
                        obscureText: true,
                        autocorrect: false,
                        autovalidate: true,
                      ),
                    ),
                    Padding (
                      padding: const EdgeInsets.only(top: 40),
                      child: RegisterButton(
                        onPressed: isRegisterButtonEnabled(state)
                            ? _onFormSubmitted
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
    );
  }

  void _onEmailChanged() {
    _regBloc.add(
        EmailChanged(email: _emailController.text)
    );
  }

  void _onPasswordChanged() {
    _regBloc.add(
        PasswordChanged(password: _passwordController.text)
    );
  }

  void _onFormSubmitted() {
    if (_passwordController.text==_passwordController2.text){
      _regBloc.add(
          Submitted(
              email: _emailController.text,
              password: _passwordController.text
          )
      );
    }else{
      _ackAlert(context);
    }
  }
  Future _ackAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Las contraseñas no coinciden'),
          actions: [
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}