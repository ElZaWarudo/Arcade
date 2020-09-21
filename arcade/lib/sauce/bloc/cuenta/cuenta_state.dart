import 'package:arcade/sauce/models/cuenta.dart';
import 'package:equatable/equatable.dart';

abstract class CueState extends Equatable {
  const CueState();

  @override
  List<Object> get props =>[];
}

class SinUsername extends CueState{
  String toString() => 'Obteniendo User';
}

class Fallo extends CueState {
  @override
  String toString() => 'Fallo al cargar';
}

class Obtenido extends CueState {
  final List<cuenta> name;

  const Obtenido([this.name]);

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'Obtenido';
}