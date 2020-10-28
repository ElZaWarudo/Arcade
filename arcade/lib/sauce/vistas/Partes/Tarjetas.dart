import 'package:arcade/sauce/bloc/juegos/jue_bloc.dart';
import 'package:arcade/sauce/models/juegos.dart';
import 'package:arcade/sauce/vistas/Partes/DatosJuego.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tarjetas extends StatefulWidget {
  String Nombre;

  Tarjetas(this.Nombre);

  @override
  _TarjetasState createState() => _TarjetasState(Nombre);
}

class _TarjetasState extends State<Tarjetas> {
  String Nombre;
  List<Juego> juegosList = [];

  _TarjetasState(this.Nombre);

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
              : GridView.builder(
                  itemCount: juegosList.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1
            ),
                  itemBuilder: (_, index) {
                    return GameUI(
                        juegosList[index].nombre,
                        juegosList[index].url,
                        juegosList[index].descripcion,
                        juegosList[index].UrlJuego);
                  },
                ),
        );
      }
      return Container();
    });
  }

  Widget GameUI(String nombre, String imagen, String descripcion, String Url) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.all(2),
      child: Container(
        padding: EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DatosJuego(nombre,imagen,descripcion,Url, Nombre)),
                      );
                    },
                  child: Image.network(
                    imagen,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    nombre,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontFamily: 'Audiowide',
                        fontWeight: FontWeight.bold, fontSize: 14.0,),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
