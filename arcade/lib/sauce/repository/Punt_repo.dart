import 'package:arcade/sauce/models/Score.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PuntRepo{
  final databaseReference=FirebaseFirestore.instance;

  Stream<List<Score>> getCatastrofe(){
    return databaseReference.collection("CatastrofeEnElEspacio").snapshots()
        .map((snapshot){
      return snapshot.docs.map((doc) => Score.fromSnapshot(doc)).toList();
    });
  }
}