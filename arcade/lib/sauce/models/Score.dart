import 'package:cloud_firestore/cloud_firestore.dart';

class Score{
  final String id, jugador;
  final int puntaje;


  Score(this.id, this.jugador, this.puntaje);

  static Score fromSnapshot(DocumentSnapshot snapshot){
    return Score(
        snapshot.id,
        snapshot.data()['Jugador'],
        snapshot.data()['Puntaje']
    );
  }
}