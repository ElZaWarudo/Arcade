import 'package:equatable/equatable.dart';

abstract class VeriState extends Equatable {
  const VeriState();

  @override
  List<Object> get props =>[];
}

class Comprobar extends VeriState{
  @override
  String toString() => 'Comprobar';
}

class Esperando extends VeriState{
  @override
  String toString() => 'Comprobando';
}

class Verificado extends VeriState{
  @override
  String toString() => 'Verificado';
}

class NoVerificado extends VeriState{
  @override
  String toString() => 'No Verificado';
}


