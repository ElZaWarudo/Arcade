import 'package:cloud_firestore/cloud_firestore.dart';

class Juego{
  final String id, nombre, descripcion, url;

  const Juego(this.id, this.nombre, this.descripcion, this.url);


  static Juego fromSnapshot(DocumentSnapshot snapshot){
    return Juego(
      snapshot.id,
      snapshot.data()['Nombre'],
      snapshot.data()['Descripción'],
      snapshot.data()['Url']
    );
  }
}