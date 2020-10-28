import 'dart:async';
import 'package:arcade/sauce/repository/Punt_repo.dart';
import 'package:bloc/bloc.dart';
import 'bloc.dart';
import 'package:meta/meta.dart';

class PuntBloc extends Bloc<PuntEvent, PuntState> {
  final PuntRepo _puntRepo;
  StreamSubscription _puntSubscription;

  PuntBloc({@required PuntRepo puntRepo})
      : assert(puntRepo != null),
        _puntRepo = puntRepo, super(ScoresLoading());



  @override
  Stream<PuntState> mapEventToState(
      PuntEvent event,
      ) async* {
    if (event is LoadPunt) {
      yield* _mapLoadGamesToState(event);
    }else if (event is Actualizar){
      yield* _mapActualizarToState(event);
    }
  }

  Stream<PuntState> _mapLoadGamesToState(event) async* {
    yield ScoresLoading();
    _puntSubscription?.cancel();
    try {
      _puntSubscription = _puntRepo.getTabla(event.Juego).listen(
              (name) => add(Actualizar(name))
      );
    } catch (_) {
      yield ScoresNotLoaded();
    }
  }

  Stream<PuntState> _mapActualizarToState(Actualizar event) async*{
    yield ScoresLoaded(event.Puntajes);
  }

  Future<void> close(){
    _puntSubscription.cancel();
    return super.close();
  }
}