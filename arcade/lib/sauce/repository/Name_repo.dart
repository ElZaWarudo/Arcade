import 'package:arcade/sauce/models/name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NameRepo{
  final String email;
  final databaseReference=FirebaseFirestore.instance;

  NameRepo(this.email);

  Stream<List<Name>> getName(){
    return databaseReference.collection("Usuarios").where("Email", isEqualTo: email).snapshots()
        .map((snapshot){
      return snapshot.docs.map((doc) => Name.fromSnapshot(doc)).toList();
    });
  }
}