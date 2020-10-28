import 'package:arcade/sauce/models/Score.dart';
import 'package:equatable/equatable.dart';

abstract class PuntEvent extends Equatable {
  const PuntEvent();

  @override
  List<Object> get props => [];
}

class LoadPunt extends PuntEvent {
  final String Juego;

  LoadPunt(this.Juego);

  @override
  List<Object> get props => [Juego];
}

class Actualizar extends PuntEvent{
  final List<Score> Puntajes;

  const Actualizar(this.Puntajes);

  @override
  List<Object> get props => [Puntajes];
}
