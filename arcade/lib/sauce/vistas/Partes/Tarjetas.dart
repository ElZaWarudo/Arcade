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
  InterstitialAd _interstitialAd;
  bool _isInterstitialReady=false;
  String Nombre;
  String juego1,imagen1,descripcion1,url1;
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
    LoadAdd();
  }

  Future<void> LoadAdd()async{
    _interstitialAd = InterstitialAd(
        adUnitId: Ads.example,
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

  Widget GameUI(String nombre, String imagen, String descripcion, String Url){
    juego1=nombre;
    imagen1=imagen;
    descripcion1=descripcion;
    url1=Url;
    return GestureDetector(
      onTap: () {
        LoadAdd();
        if(_isInterstitialReady==true){
          _interstitialAd.show();
          _interstitialAd=null;
        }else{
          _toInfo(nombre, imagen, descripcion, Url);
        }
      },
      child: Card(
        elevation: 3.0,
        margin: EdgeInsets.all(1),
        child: Container(
          padding: EdgeInsets.all(1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Stack(
                        children: [
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width*0.5,
                          ),
                          Center(
                            child: Image.network(
                              imagen,
                              height: 100,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width*0.50,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      Container(
                          child: Flexible(
                            child: Text(
                              nombre,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Audiowide',
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  _toInfo(String nombre, String imagen, String descripcion, String Url){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DatosJuego(nombre, imagen, descripcion, Url, Nombre)),
    );
  }
}




/*class Tarjetas extends StatefulWidget {
  String Nombre;


  Tarjetas(this.Nombre);

  @override
  _TarjetasState createState() => _TarjetasState(Nombre);
}

class _TarjetasState extends State<Tarjetas> {
  InterstitialAd _interstitialAd;
  bool _isInterstitialReady=false;
  String Nombre;
  String juego1,imagen1,descripcion1,url1;
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
    LoadAdd();
  }

  void LoadAdd(){
    _interstitialAd = InterstitialAd(
        adUnitId: Ads.example,
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

  Widget GameUI(String nombre, String imagen, String descripcion, String Url){
    juego1=nombre;
    imagen1=imagen;
    descripcion1=descripcion;
    url1=Url;
    return GestureDetector(
      onTap: () {
        LoadAdd();
        if(_isInterstitialReady==true){
          _interstitialAd.show();
          _interstitialAd=null;
        }else{
          _toInfo(nombre, imagen, descripcion, Url);
        }
      },
      child: Card(
        elevation: 3.0,
        margin: EdgeInsets.all(1),
        child: Container(
          padding: EdgeInsets.all(1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.network(
                        imagen,
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                      Container(
                        width: 12,
                      ),
                      Container(
                          child: Flexible(
                            child: Text(
                              nombre,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Audiowide',
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  _toInfo(String nombre, String imagen, String descripcion, String Url){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DatosJuego(nombre, imagen, descripcion, Url, Nombre)),
    );
  }
}
*/