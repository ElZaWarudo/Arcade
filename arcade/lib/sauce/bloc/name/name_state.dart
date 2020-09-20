import 'package:arcade/sauce/models/name.dart';
import 'package:equatable/equatable.dart';

abstract class NameState extends Equatable {
  const NameState();

  @override
  List<Object> get props =>[];
}

class SinUsername extends NameState{
  String toString() => 'Obteniendo User';
}

class Fallo extends NameState {
  @override
  String toString() => 'Fallo al cargar';
}

class Obtenido extends NameState {
  final List<Name> name;

  const Obtenido([this.name]);

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'Obtenido';
}