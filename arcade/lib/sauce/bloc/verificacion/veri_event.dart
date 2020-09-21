import 'package:equatable/equatable.dart';

abstract class VeriEvent extends Equatable {
  const VeriEvent();

  @override
  List<Object> get props => [];
}
class Empezar extends VeriEvent {}

class PedirConfirmacion extends VeriEvent {}


