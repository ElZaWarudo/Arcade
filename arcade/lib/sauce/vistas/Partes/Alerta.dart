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
          title: Text("Ingresa tu nombre de usuario, así seras visto en las tablas de puntuaciones"),
          content: Form(
            child: TextFormField(
                controller: _Controller,
                obscureText: false,
                autocorrect: false,
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text("¡Vamos!"),
              onPressed: (){
                _ackAlert2();
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
                    ? Agregar(context)
                    : AlertDialog(
                  title: Text("Este nombre de usuario ya esta en uso"),
                  actions: <Widget>[
                    RaisedButton(
                      child: Text("Aceptar"),
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

  Widget Agregar(BuildContext context) {
    agr();
    return Container();
  }
  void agr() {
    int count = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.popUntil(context, (route) {
        return count++ == 2;
      });
    });
    BlocProvider.of<CueBloc>(context).add(AddCue(email, _Controller.text));
  }


}
