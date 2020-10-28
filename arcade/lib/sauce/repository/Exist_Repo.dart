import 'package:arcade/sauce/models/cuenta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExRepo{
  final databaseReference=FirebaseFirestore.instance;

  Stream<List<cuenta>> getUser(String user){
    return databaseReference.collection("Usuarios").where("Usuario", isEqualTo: user).snapshots()
        .map((snapshot){
      return snapshot.docs.map((doc) => cuenta.fromSnapshot(doc)).toList();
    });
  }

}