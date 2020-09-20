import 'package:equatable/equatable.dart';

abstract class NameEvent extends Equatable {
  const NameEvent();

  @override
  List<Object> get props => [];
}

class BuscarName extends NameEvent {}