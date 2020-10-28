import 'dart:async';
import 'package:arcade/sauce/repository/Exist_Repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'bloc.dart';

class ExBloc extends Bloc<ExEvent, ExState> {
  final ExRepo _ExRepo;
  StreamSubscription _ExSubscription;


  ExBloc({@required ExRepo exRepo})
      : assert(exRepo != null),
        _ExRepo = exRepo, super(SinUser());



  @override
  Stream<ExState> mapEventToState(
      ExEvent event,
      ) async* {
    if (event is BuscarUser) {
      yield* _mapLoadNamesToState(event);
    } else if (event is Actualizar){
      yield* _mapActualizarToState(event);
    }
  }

  Stream<ExState> _mapLoadNamesToState(event) async* {
    yield SinUser();
    _ExSubscription?.cancel();
    try {
      _ExSubscription = _ExRepo.getUser(event.user).listen(
              (name) => add(Actualizar(name))
      );
    } catch (_) {
      yield Fallado();
    }
  }

  Stream<ExState> _mapActualizarToState(Actualizar event) async*{
    yield UsrObtenido(event.cuentas);
  }


  Future<void> close(){
    _ExSubscription.cancel();
    return super.close();
  }
}