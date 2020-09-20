import 'package:equatable/equatable.dart';

abstract class AutState extends Equatable {
  const AutState();

  @override
  List<Object> get props =>[];
}

//Estados de Aut

//No inicializado
class NoInicializado extends AutState{
  @override
  String toString() => 'No inicializado';
}

//Autenticado
class Autenticado extends AutState{
  final String Email;
  const Autenticado(this.Email);

  @override
  List<Object> get props => [Email];

  @override
  String toString() => 'Autenticado -displayname:$Email';
}

//NoAutenticado
class NoAutenticado extends AutState {
  @override
  String toString() => 'No autenticado';

}