import 'package:equatable/equatable.dart';

abstract class CueEvent extends Equatable {
  const CueEvent();

  @override
  List<Object> get props => [];
}

class BuscarName extends CueEvent {}