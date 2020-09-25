import 'dart:async';
import 'package:arcade/sauce/models/Score.dart';
import 'package:arcade/sauce/repository/Punt_repo.dart';
import 'package:bloc/bloc.dart';
import 'bloc.dart';
import 'package:meta/meta.dart';

class PuntBloc extends Bloc<PuntEvent, PuntState> {
  final PuntRepo _puntRepo;

  PuntBloc({@required PuntRepo puntRepo})
      : assert(puntRepo != null),
        _puntRepo = puntRepo, super(ScoresLoading());



  @override
  Stream<PuntState> mapEventToState(
      PuntEvent event,
      ) async* {
    if (event is LoadPunt) {
      yield* _mapLoadGamesToState();
    }
  }

  Stream<PuntState> _mapLoadGamesToState() async* {
    yield ScoresLoading();
    try {
      final List<Score> scores = await _puntRepo.getCatastrofe().first;
      yield ScoresLoaded(scores);
    } catch (_) {
      yield ScoresNotLoaded();
    }
  }
}