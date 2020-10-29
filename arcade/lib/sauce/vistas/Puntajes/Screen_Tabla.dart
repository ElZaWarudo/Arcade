import 'package:arcade/sauce/bloc/Puntuaciones/bloc.dart';
import 'package:arcade/sauce/repository/Punt_repo.dart';
import 'package:arcade/sauce/vistas/Puntajes/Tabla.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TablaScreen extends StatelessWidget {

  TablaScreen({Key key})
      :super(key: key);

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
      body: BlocProvider<PuntBloc>(
        create: (context) => PuntBloc(puntRepo: PuntRepo())..add(LoadPunt("CatastrofeEnElEspacio")),
        child: Tabla()
      ),
    );
  }
}
