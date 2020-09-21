import 'package:arcade/sauce/models/cuenta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CueRepo{
  final String email;
  final databaseReference=FirebaseFirestore.instance;

  CueRepo(this.email);

  Stream<List<cuenta>> getCue(){
    return databaseReference.collection("Usuarios").where("Email", isEqualTo: email).snapshots()
        .map((snapshot){
      return snapshot.docs.map((doc) => cuenta.fromSnapshot(doc)).toList();
    });
  }

}