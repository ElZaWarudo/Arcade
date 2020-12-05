import 'package:arcade/sauce/vistas/APIs/Ads.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ApoyoTarjeta extends StatelessWidget {
  bool _isRewardReady=false;
  BuildContext _context;

  void _loadRewardedAd(){
    RewardedVideoAd.instance.load(adUnitId: Ads.rewarded);
  }

  _onRewardedEvent(RewardedVideoAdEvent event,{String rewardType, int rewardAmount}){
    switch(event){
      case RewardedVideoAdEvent.loaded:
        _isRewardReady=true;
        break;
      case RewardedVideoAdEvent.failedToLoad:
        _isRewardReady=false;
        break;
      case RewardedVideoAdEvent.closed:
        _isRewardReady=false;
        LoadAdd();
        break;
      case RewardedVideoAdEvent.rewarded:
        Snack("Gracias por tu apoyo!");
        break;
    }
  }

  void LoadAdd(){
    _loadRewardedAd();
    RewardedVideoAd.instance.listener = _onRewardedEvent;
  }

  @override
  Widget build(BuildContext context) {
    _context=context;
    LoadAdd();
    final miniatura = new Container(
      alignment: new FractionalOffset(0.0, 0.3),
      margin: const EdgeInsets.only(left: 9.0),
      child: new Hero(
        tag: "juego: Apoyanos",
        child: Container(
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage("https://cursosmultimedia.es/tutoresformacion/wp-content/uploads/2020/02/apoyo-3.jpg"),
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
            new Text("APOYANOS", style: TextStyle(color: Colors.white,fontFamily: 'Lemonmilk')),
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
                      if(_isRewardReady){
                        RewardedVideoAd.instance.show();
                      }else{
                        Snack("No se pudo mostrar...");
                      }
                    },
                    icon: Icon(FontAwesomeIcons.ad, color: Colors.white,),
                    label: Text("  Ver video", style: TextStyle(fontFamily: 'Lemonmilk', color: Colors.white)),
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
      margin: const EdgeInsets.only(top: 8.0, bottom: 3),
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

  void Snack(String text){
    final snack=SnackBar(content: Text(text));
    Scaffold.of(_context).showSnackBar(snack);
  }
}
