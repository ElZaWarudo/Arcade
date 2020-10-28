import 'dart:io';

import 'package:arcade/sauce/models/cuenta.dart';
import 'package:equatable/equatable.dart';

abstract class CueEvent extends Equatable {
  const CueEvent();

  @override
  List<Object> get props => [];
}

class BuscarName extends CueEvent {}

class AddCue extends CueEvent{
  final String email, usuario;

  const AddCue(this.email,this.usuario);

  @override
  List<Object> get props => [email, usuario];

  @override
  String toString() => "añadiendo a la bd";
}

class Actualizar extends CueEvent{
  final List<cuenta> cuentas;

  const Actualizar(this.cuentas);

  @override
  List<Object> get props => [cuentas];
}

class ChangeImage extends CueEvent{
  final File image;
  final String email,id;

  const ChangeImage(this.image, this.email, this.id);

  List<Object> get props => [image,email,id];

  String toString() => "Actualizando foto...";
}


