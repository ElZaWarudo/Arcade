import 'dart:io';
import 'package:arcade/sauce/models/cuenta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CueRepo{
  final String email;
  final databaseReference=FirebaseFirestore.instance.collection("Usuarios");

  CueRepo(this.email);

  Stream<List<cuenta>> getCue(){
    return databaseReference.where("Email", isEqualTo: email).snapshots()
        .map((snapshot){
      return snapshot.docs.map((doc) => cuenta.fromSnapshot(doc)).toList();
    });
  }

  Future<void> PutCue(String email, String usuario){
    return databaseReference
        .add({
        'Email': email,
        'UrlImagen': "https://0.soompi.io/wp-content/uploads/sites/8/2016/02/14030437/mystery-Man-Soompi.jpg?s=900x600&e=t",
        'Usuario': usuario
    });
  }

  Stream<List<cuenta>> getUser(String user){
    databaseReference.where("User", isEqualTo: user).snapshots()
        .map((snapshot){
      return snapshot.docs.map((doc) => cuenta.fromSnapshot(doc)).toList();
    });
  }


  Future<void> ChangeImage(File image, String email, String id) async {
    // Save image
    final StorageReference postImageRef = FirebaseStorage().ref().child("Imagenes usuarios");
    final StorageUploadTask uploadTask =
    postImageRef.child("$email.jpg").putFile(image);
    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    var url = imageUrl.toString();
    databaseReference.doc(id).update({'UrlImagen': url});
  }

}