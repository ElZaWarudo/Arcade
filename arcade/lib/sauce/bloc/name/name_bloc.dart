import 'dart:async';
import 'package:arcade/sauce/models/name.dart';
import 'package:arcade/sauce/repository/Name_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'bloc.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  final NameRepo _nameRepo;

  NameBloc({@required NameRepo nameRepo})
      : assert(nameRepo != null),
        _nameRepo = nameRepo, super(SinUsername());



  @override
  Stream<NameState> mapEventToState(
      NameEvent event,
      ) async* {
    if (event is BuscarName) {
      yield* _mapLoadNamesToState();
    }
  }

  Stream<NameState> _mapLoadNamesToState() async* {
    yield SinUsername();
    try {
      final List<Name> name = await _nameRepo.getName().first;
      yield Obtenido(name);
    } catch (_) {
      yield Fallo();
    }
  }
}