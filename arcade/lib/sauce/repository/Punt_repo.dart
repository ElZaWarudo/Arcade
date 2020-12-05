import 'package:arcade/sauce/models/Score.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PuntRepo{
  final databaseReference=FirebaseFirestore.instance;

  Stream<List<Score>> getTabla(String Juego){
    return databaseReference.collection(Juego).orderBy("Puntaje",descending:true).limit(20).snapshots()
        .map((snapshot){
      return snapshot.docs.map((doc) => Score.fromSnapshot(doc)).toList();
    });
  }
}