import 'package:cloud_firestore/cloud_firestore.dart';

class Name{
  final String id, email, usuario, urlImagen;

  const Name(this.id,this.email, this.usuario, this.urlImagen);


  static Name fromSnapshot(DocumentSnapshot snapshot){
    return Name(
        snapshot.id,
        snapshot.data()['Email'],
        snapshot.data()['Usuario'],
        snapshot.data()['UrlImagen']
    );
  }
}