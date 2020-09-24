import 'package:arcade/sauce/Vistas/Login/bot_logueo/create.dart';
import 'package:arcade/sauce/bloc/autenticacion/aut_event.dart';
import 'package:arcade/sauce/bloc/login/log_bloc.dart';
import 'package:arcade/sauce/bloc/login/log_event.dart';
import 'package:arcade/sauce/bloc/login/log_state.dart';
import 'package:arcade/sauce/repository/User_Repo.dart';
import 'package:flutter/material.dart';
import 'package:arcade/sauce/bloc/autenticacion/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bot_logueo/google.dart';
import 'bot_logueo/login.dart';

class LoginForm extends StatefulWidget {
  final UserRepo _userRepo;

  LoginForm({Key key, @required UserRepo userRepo})
      : assert(userRepo != null),
        _userRepo = userRepo,
        super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserRepo get _userRepo => widget._userRepo;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      // tres casos, tres if:
      if (state.isFailure) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Login Failure'), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ),
          );
      }
      if (state.isSubmitting) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Logging in... '),
                CircularProgressIndicator(),
              ],
            ),
          ));
      }
      if (state.isSuccess) {
        BlocProvider.of<AutBloc>(context).add(LoggedIn());
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            child: ListView(children: [
              Image.asset(
                'lib/assets/varcade.png',
                height: 300.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: GoogleLoginButton(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: RaisedButton(
                  color: Colors.indigo,
                  textColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.facebookSquare),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text('Log In con Facebook'),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "Correo Electronico"),
                  keyboardType: TextInputType.emailAddress,
                  autovalidate: true,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isEmailValid ? 'Correo invalido' : null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: "Contraseña"),
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  autovalidate: true,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isPasswordValid
                        ? 'Contraseña invalida'
                        : null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: LoginButton(
                  onPressed:
                      isLoginButtonEnabled(state) ? _onFormSubmitted : null,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 40),
                  child: CreateAccount(userRepo: _userRepo)),
            ]),
          ),
        );
      },
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }
}
