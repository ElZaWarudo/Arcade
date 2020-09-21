import 'dart:async';
import 'package:arcade/sauce/models/cuenta.dart';
import 'package:arcade/sauce/repository/Cue_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'bloc.dart';

class CueBloc extends Bloc<CueEvent, CueState> {
  final CueRepo _cueRepo;


  CueBloc({@required CueRepo cueRepo})
      : assert(cueRepo != null),
        _cueRepo = cueRepo, super(SinUsername());



  @override
  Stream<CueState> mapEventToState(
      CueEvent event,
      ) async* {
    if (event is BuscarName) {
      yield* _mapLoadNamesToState();
    }
  }

  Stream<CueState> _mapLoadNamesToState() async* {
    yield SinUsername();
    try {
      final List<cuenta> name = await _cueRepo.getCue().first;

      yield Obtenido(name);
    } catch (_) {
      yield Fallo();
    }
  }
}