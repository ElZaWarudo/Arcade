import 'package:arcade/sauce/bloc/juegos/jue_bloc.dart';
import 'package:arcade/sauce/models/juegos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tarjetas extends StatefulWidget {
  @override
  _TarjetasState createState() => _TarjetasState();
}

class _TarjetasState extends State<Tarjetas> {
  List<Juego> juegosList = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JueBloc, JueState>(builder: (context, state) {
      if (state is GamesLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is GamesNotLoaded) {
        return Center(
          child: Column(
            children: <Widget>[
              Icon(FontAwesomeIcons.exclamationTriangle),
              Text('Algo salió mal...'),
            ],
          ),
        );
      }
      if (state is GamesLoaded) {
        juegosList = state.juegos;
        return Container(
            child: juegosList.length == 0
                ? Center(
                    child: Text('Aun no hay juegos'),
                  )
                : ListView.builder(
                    itemCount: juegosList.length,
                    itemBuilder: (_, index) {
                      return GameUI(
                        juegosList[index].nombre,
                        juegosList[index].url,
                        juegosList[index].descripcion,
                      );
                    }));
      }
      return Container();
    });
  }

  Widget GameUI(String nombre, String imagen, String descripcion) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.all(14.0),
      child: Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  nombre,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Image.network(
              imagen,
              fit: BoxFit.cover,
            ),
            Text(
              descripcion,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: RaisedButton(
                  child: Text('Jugar'),
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  onPressed: () {

                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
