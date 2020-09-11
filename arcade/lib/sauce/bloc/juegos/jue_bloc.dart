import 'dart:async';
import 'dart:io';
import 'package:arcade/sauce/models/juegos.dart';
import 'package:bloc/bloc.dart';
import 'package:arcade/sauce/repository/Juego_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'jue_event.dart';
part 'jue_state.dart';

class JueBloc extends Bloc<JueEvent, JueState> {
  final JueRepo _jueRepo;

  JueBloc({@required JueRepo jueRepo})
      : assert(jueRepo != null),
        _jueRepo = jueRepo, super(GamesLoading());



  @override
  Stream<JueState> mapEventToState(
      JueEvent event,
      ) async* {
    if (event is LoadJue) {
      yield* _mapLoadGamesToState();
    }
  }

  Stream<JueState> _mapLoadGamesToState() async* {
    yield GamesLoading();
    try {
      final List<Juego> juegos = await _jueRepo.getJuegos().first;
      yield GamesLoaded(juegos);
    } catch (_) {
      yield GamesNotLoaded();
    }
  }
}