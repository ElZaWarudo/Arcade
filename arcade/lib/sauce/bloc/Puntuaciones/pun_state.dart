import 'package:arcade/sauce/models/Score.dart';
import 'package:equatable/equatable.dart';


abstract class PuntState extends Equatable {
  const PuntState();

  @override
  List<Object> get props => [];
}


class ScoresLoading extends PuntState {
  @override
  String toString() => 'Cargando';
}

class ScoresLoaded extends PuntState {
  final List<Score> scores;

  const ScoresLoaded([this.scores]);

  @override
  List<Object> get props => [scores];

  @override
  String toString() => 'Cargado';
}

class ScoresNotLoaded extends PuntState {
  @override
  String toString() => 'Fallo al cargar';
}