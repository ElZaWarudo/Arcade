import 'package:arcade/sauce/bloc/cuenta/bloc.dart';
import 'package:arcade/sauce/bloc/cuenta/cuenta_bloc.dart';
import 'package:arcade/sauce/bloc/exist/bloc.dart';
import 'package:arcade/sauce/models/cuenta.dart';
import 'package:arcade/sauce/repository/Exist_Repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Alerta extends StatefulWidget {
  String name;

  Alerta(this.name);

  @override
  _AlertaState createState() => _AlertaState(name);
}

class _AlertaState extends State<Alerta> {
  final TextEditingController _Controller = TextEditingController();
  final String email;
  List<cuenta> NameList = [];

  _AlertaState(this.email);

  @override
  void initState() {
    _ackAlert();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future _ackAlert() async {
    await Future.delayed(Duration(milliseconds: 50));
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff683ab7),
          title: Text(
            "Ingresa tu nombre de usuario, así seras visto en las tablas de puntuaciones",
            style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
          ),
          content: Form(
            child: TextFormField(
              style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
              controller: _Controller,
              obscureText: false,
              autocorrect: false,
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.black,
              child: Text(
                "¡Vamos!",
                style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
              ),
              onPressed: () {
                if (_Controller.text.length != 0) {
                  if (_Controller.text.length < 8) {
                    _ackAlert1("Prueba con un nombre mas largo");
                  } else {
                    _ackAlert2();
                  }
                } else {
                  _ackAlert1("El vacio no es un usuario valido");
                }
              },
            )
          ],
        );
      },
    );
  }

  Future _ackAlert1(String text) async {
    await Future.delayed(Duration(milliseconds: 20));
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff683ab7),
          title: Text(
            text,
            style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
          ),
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.black,
              child: Text(
                "¡Entendido!",
                style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
              ),
              onPressed: () {
                int count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 1;
                });
              },
            )
          ],
        );
      },
    );
  }

  Future _ackAlert2() async {
    await Future.delayed(Duration(milliseconds: 50));
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<ExBloc, ExState>(
          cubit: ExBloc(exRepo: ExRepo())..add(BuscarUser(_Controller.text)),
          builder: (context, state) {
            if (state is SinUsername) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is Fallado) {
              return Center(
                child: Column(
                  children: <Widget>[
                    Text('Algo salió mal...'),
                  ],
                ),
              );
            }
            if (state is UsrObtenido) {
              NameList = state.name;
              return Container(
                child: NameList.length == 0
                    ? pan()
                    : AlertDialog(
                        backgroundColor: Color(0xff683ab7),
                        title: Text(
                          "Este nombre de usuario ya esta en uso",
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'OpenSans'),
                        ),
                        actions: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.black,
                            child: Text(
                              "Aceptar",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'OpenSans'),
                            ),
                            onPressed: () {
                              int count = 0;
                              Navigator.popUntil(context, (route) {
                                return count++ == 1;
                              });
                            },
                          )
                        ],
                      ),
              );
            }
            return Container();
          },
        );
      },
    );
  }

  Widget pan() {
    _ackAlert3();
    return Container();
  }

  Future _ackAlert3() async {
    await Future.delayed(Duration(milliseconds: 20));
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff683ab7),
          title: Text(_Controller.text,
            style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
          ),
          content: Text(
            "¿Estas seguro de este nombre?\n\nNo lo podras cambiar después",
            style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
          ),
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.black,
              child: Text("¡Si!",
                style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
              ),
              onPressed: () {
                agr();
              },
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.black,
              child: Text("No",
                style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
              ),
              onPressed: () {
                int count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 2;
                });
              },
            )
          ],
        );
      },
    );
  }

  void agr() {
    int count = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.popUntil(context, (route) {
        return count++ == 3;
      });
    });
    BlocProvider.of<CueBloc>(context).add(AddCue(email, _Controller.text));
  }
}
