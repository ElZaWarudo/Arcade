import 'package:cloud_firestore/cloud_firestore.dart';

class cuenta{
  final String id, email, usuario, urlImagen;

  const cuenta(this.id,this.email, this.usuario, this.urlImagen);


  static cuenta fromSnapshot(DocumentSnapshot snapshot){
    return cuenta(
        snapshot.id,
        snapshot.data()['Email'],
        snapshot.data()['Usuario'],
        snapshot.data()['UrlImagen'],
    );
  }
}