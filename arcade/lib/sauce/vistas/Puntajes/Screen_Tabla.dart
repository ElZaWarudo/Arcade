import 'package:arcade/sauce/bloc/Puntuaciones/bloc.dart';
import 'package:arcade/sauce/repository/Punt_repo.dart';
import 'package:arcade/sauce/vistas/Puntajes/Tabla.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TablaScreen extends StatelessWidget {
  TablaScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Records',
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff683ab7),
                Color(0xff683ab7),
                Color(0xff334db2),
                Color(0xff3955bc)
              ]),
        ),
        child: BlocProvider<PuntBloc>(
            create: (context) => PuntBloc(puntRepo: PuntRepo())
              ..add(LoadPunt("CatastrofeEnElEspacio")),
            child: Tabla()),
      ),
    );
  }
}
