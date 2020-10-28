import 'package:arcade/sauce/vistas/Puntajes/Screen_Tabla.dart';
import 'package:flutter/material.dart';

import '../WebGame.dart';

class DatosJuego extends StatelessWidget {
  String nombre, imagen, descripcion, Url, Jugador;
  final Color icon = Color(0xff522da8);
  final Color color1 = Color(0xff321b92);
  final Color color2 = Color(0xff683ab7);
  final Color color3 = Color(0xff7f57c2);

  DatosJuego(
      this.nombre, this.imagen, this.descripcion, this.Url, this.Jugador);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 350,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [color2, color3],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                )),
            Positioned(
                top: 350,
                left: 0,
                right: 150,
                bottom: 80,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: color1,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50.0))),
                )),
            Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    Text(
                      nombre.toUpperCase(), textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 30.0),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      descripcion,
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 50.0),
                    SizedBox(
                      height: 30.0,
                      width: double.infinity,
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 380,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.black38, blurRadius: 30.0)
              ]),
              child: SizedBox(
                height: 350,
                child: Image.network(
                  imagen,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                top: 325,
                left: 20,
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Color(0xff683ab7))
                  ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebGame(Url, Jugador)),
                      );
                    },
                    icon: Icon(
                      Icons.play_arrow,
                    ),
                    label: Text("Jugar")),
            ),
            Positioned(
              top: 325,
              right: 20,
              child: RaisedButton(
                child: Text("Records".toUpperCase()),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Color(0xff683ab7))),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TablaScreen()),
                  );
                },
              ),
            ),
            Container(
                height: 70.0,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
