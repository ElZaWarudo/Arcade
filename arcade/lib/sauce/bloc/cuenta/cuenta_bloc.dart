import 'dart:async';
import 'package:arcade/sauce/repository/Cue_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'bloc.dart';

class CueBloc extends Bloc<CueEvent, CueState> {
  final CueRepo _cueRepo;
  StreamSubscription _cueSubscription;


  CueBloc({@required CueRepo cueRepo})
      : assert(cueRepo != null),
        _cueRepo = cueRepo, super(SinUsername());



  @override
  Stream<CueState> mapEventToState(
      CueEvent event,
      ) async* {
    if (event is BuscarName) {
      yield* _mapLoadNamesToState();
    }else if (event is AddCue){
      yield* _mapAddCuentaToState(event);
    }else if (event is Actualizar){
      yield* _mapActualizarToState(event);
    }else if (event is ChangeImage){
      yield* _mapChangeToState(event);
    }
  }

  Stream<CueState> _mapLoadNamesToState() async* {
    yield SinUsername();
    _cueSubscription?.cancel();
    try {
      _cueSubscription = _cueRepo.getCue().listen(
          (name) => add(Actualizar(name))
      );
    } catch (_) {
      yield Fallo();
    }
  }
  Stream<CueState> _mapAddCuentaToState(AddCue event) async*{
    await _cueRepo.PutCue(event.email, event.usuario);
  }

  Stream<CueState> _mapActualizarToState(Actualizar event) async*{
    yield Obtenido(event.cuentas);
  }

  Stream<CueState> _mapChangeToState(ChangeImage event) async*{
    await _cueRepo.ChangeImage(event.image, event.email, event.id);
  }

  Future<void> close(){
    _cueSubscription.cancel();
    return super.close();
  }
}