part of 'jue_bloc.dart';


abstract class JueState extends Equatable {
  const JueState();

  @override
  List<Object> get props => [];
}


class GamesLoading extends JueState {
  @override
  String toString() => 'Cargando';
}

class GamesLoaded extends JueState {
  final List<Juego> juegos;

  const GamesLoaded([this.juegos]);

  @override
  List<Object> get props => [juegos];

  @override
  String toString() => 'Cargado';
}

class GamesNotLoaded extends JueState {
  @override
  String toString() => 'Fallo al cargar';
}