import 'package:arcade/sauce/vistas/APIs/Ads.dart';
import 'package:arcade/sauce/vistas/Puntajes/Screen_Tabla.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import '../APIs/WebGame.dart';

class DatosJuego extends StatelessWidget {
  InterstitialAd _interstitialAd;
  bool _isInterstitialReady = false;
  String nombre, imagen, descripcion, Url, Jugador;
  final Color icon = Color(0xff522da8);
  final Color color1 = Color(0xff321b92);
  final Color color2 = Color(0xff683ab7);
  final Color color3 = Color(0xff7f57c2);

  DatosJuego(
      this.nombre, this.imagen, this.descripcion, this.Url, this.Jugador);
  @override
  Widget build(BuildContext context) {
    LoadAdd(context);
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
                  decoration: BoxDecoration(
                      color: color1,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50.0))),
                )),
            Positioned(
              top: 330,
              left: 0,
              right: 0,
              bottom: 1,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    SizedBox(height: 22.0),
                    Text(
                      nombre,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0,
                          fontFamily: 'Lemonmilk'),
                    ),
                    SizedBox(height: 10.0),
                    LimitedBox(
                      maxHeight: 300,
                      child: Text(
                        descripcion,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'OpenSans'),
                      ),
                    ),
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
                  color: Color(0xff0D0430),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onPressed: () {
                    if (_isInterstitialReady == true) {
                      _interstitialAd.show();
                      _interstitialAd = null;
                    } else {
                      _ToGame(context);
                    }
                  },
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  label: Text("Jugar",
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Lemonmilk'))),
            ),
            Positioned(
              top: 325,
              right: 20,
              child: RaisedButton(
                color: Color(0xff0D0430),
                child: Text("RECORDS",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Lemonmilk')),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                onPressed: () {
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

  void LoadAdd(BuildContext context) {
    _interstitialAd = InterstitialAd(
        adUnitId: Ads.instertsticial,
        listener: (MobileAdEvent event) {
          switch (event) {
            case MobileAdEvent.loaded:
              _isInterstitialReady = true;
              break;
            case MobileAdEvent.failedToLoad:
              _isInterstitialReady = false;
              break;
            case MobileAdEvent.closed:
              _ToGame(context);
              break;
            default:
          }
        });
    _interstitialAd.load();
  }

  _ToGame(BuildContext context) async {
    final result = Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebGame(Url, Jugador)),
    );
    LoadAdd(context);
  }
}
