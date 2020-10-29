import 'package:arcade/sauce/bloc/Puntuaciones/bloc.dart';
import 'package:arcade/sauce/models/Score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tabla extends StatefulWidget {
  @override
  _TablaState createState() => _TablaState();
}

class _TablaState extends State<Tabla> {

  List<Score> scoresList = [];


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuntBloc, PuntState>(builder: (context, state) {
      if (state is ScoresLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ScoresNotLoaded) {
        return Center(
          child: Column(
            children: <Widget>[
              Icon(FontAwesomeIcons.exclamationTriangle),
              Text('Algo salió mal...'),
            ],
          ),
        );
      }
      if (state is ScoresLoaded) {
        scoresList = state.scores;
        List<DataRow> Filas = new List<DataRow>();
        for(var prop in scoresList){
          DataRow Add = DataRow(
            cells: [
              DataCell(Text(prop.jugador)),
              DataCell(Text(prop.puntaje.toString()))
            ]
          );
          Filas.add(Add);
        }
        return Container(
          child: scoresList.length == 0
              ? Center(
              child: Text('Aun no hay Puntajes'),
              )
              :
          DataTable(
            columns: [
              DataColumn(label: Text('Jugador')),
              DataColumn(label: Text('Puntaje'))
            ],
            rows: Filas,
          )
        );
      }
      return Container();
    });
  }
}