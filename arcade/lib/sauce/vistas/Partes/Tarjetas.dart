import 'package:arcade/sauce/bloc/juegos/jue_bloc.dart';
import 'package:arcade/sauce/models/juegos.dart';
import 'package:arcade/sauce/vistas/APIs/Ads.dart';
import 'package:arcade/sauce/vistas/Partes/DatosJuego.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
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
  var Iconos = [
    FontAwesomeIcons.gamepad,
    FontAwesomeIcons.ghost,
    FontAwesomeIcons.dragon,
    FontAwesomeIcons.diceD20,
    FontAwesomeIcons.hatWizard,
    FontAwesomeIcons.laughBeam,
    FontAwesomeIcons.puzzlePiece,
    FontAwesomeIcons.bowlingBall,
    FontAwesomeIcons.bomb,
    FontAwesomeIcons.galacticSenate,
    FontAwesomeIcons.radiation
  ];
  InterstitialAd _interstitialAd;
  bool _isInterstitialReady = false;
  String Nombre;
  String juego1, imagen1, descripcion1, url1;
  List<Juego> juegosList = [];

  _TarjetasState(this.Nombre);

  @override
  void dispose() {
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
              _toInfo(juego1, imagen1, descripcion1, url1);
              break;
            default:
          }
        });
    _interstitialAd.load();
  }


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
                        juegosList[index].UrlJuego);
                  },
                ),
        );
      }
      return Container();
    });
  }

  _toInfo(String nombre, String imagen, String descripcion, String Url) async{
    final espera = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DatosJuego(nombre, imagen, descripcion, Url, Nombre),
      ),
    );
    LoadAdd();
  }

  Widget GameUI(String nombre, String imagen, String descripcion, String Url) {
    juego1 = nombre;
    imagen1 = imagen;
    descripcion1 = descripcion;
    url1 = Url;
    final miniatura = new Container(
      alignment: new FractionalOffset(0.0, 0.3),
      margin: const EdgeInsets.only(left: 9.0),
      child: new Hero(
        tag: "juego: $nombre",
        child: Container(
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage(imagen),
            ),
          ),
        ),
      ),
    );

    final gameCard = new Container(
      margin: const EdgeInsets.only(left: 50.0, right: 12.0),
      decoration: new BoxDecoration(
        color: Color(0xff683ab7),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(15.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
              color: Color(0xff553194),
              blurRadius: 10.0,
              offset: new Offset(8.0, 8.0))
        ],
      ),
      child: new Container(
        margin: const EdgeInsets.only(top: 16.0, left: 40.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text(nombre, style: TextStyle(color: Colors.white,fontFamily: 'Lemonmilk')),
            /*---------------------*/
            new Container(
                color: Colors.white,
                width: 100.0,
                height: 1.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0)),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 8.0, bottom: 8),
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.black,
                    onPressed: () {
                      if (_isInterstitialReady == true) {
                        _interstitialAd.show();
                      } else {
                        _toInfo(nombre, imagen, descripcion, Url);
                      }
                    },
                    icon: Icon((Iconos.toList()..shuffle()).first, color: Colors.white,),
                    label: Text(" Información", style: TextStyle(fontFamily: 'Lemonmilk', color: Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return new Container(
      height: 120.0,
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: new Container(
        child: new Stack(
          children: <Widget>[
            gameCard,
            miniatura,
          ],
        ),
      ),
    );
  }
  Future<void> LoadAdd() async {
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
              _toInfo(juego1, imagen1, descripcion1, url1);
              break;
            default:
          }
        });
    _interstitialAd.load();
  }
}
