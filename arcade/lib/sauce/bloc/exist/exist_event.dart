import 'package:arcade/sauce/models/cuenta.dart';
import 'package:equatable/equatable.dart';

abstract class ExEvent extends Equatable {
  const ExEvent();

  @override
  List<Object> get props => [];
}

class BuscarUser extends ExEvent {
  final String user;

  BuscarUser(this.user);

  @override
  List<Object> get props => [user];
}


class Actualizar extends ExEvent{
  final List<cuenta> cuentas;

  const Actualizar(this.cuentas);

  @override
  List<Object> get props => [cuentas];
}


class Consultar extends ExEvent{
  final String user;

  const Consultar(this.user);


}