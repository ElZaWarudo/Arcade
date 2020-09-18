import 'package:arcade/sauce/models/juegos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JueRepo{
  final databaseReference=FirebaseFirestore.instance;

  Stream<List<Juego>> getJuegos(){
    return databaseReference.collection("Juegos").snapshots()
        .map((snapshot){
          return snapshot.docs.map((doc) => Juego.fromSnapshot(doc)).toList();
    });
  }
}