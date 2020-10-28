import 'package:arcade/sauce/models/cuenta.dart';
import 'package:equatable/equatable.dart';

abstract class ExState extends Equatable {
  const ExState();

  @override
  List<Object> get props =>[];
}

class SinUser extends ExState{
  String toString() => 'Obteniendo User';
}

class Fallado extends ExState {
  @override
  String toString() => 'Fallo al cargar';
}

class UsrObtenido extends ExState {
  final List<cuenta> name;

  const UsrObtenido([this.name]);

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'Obtenido...';
}