import 'package:arcade/sauce/bloc/verificacion/bloc.dart';
import 'package:arcade/sauce/repository/User_Repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'veri_state.dart';

class VeriBloc extends Bloc<VeriEvent, VeriState>{
  final UserRepo _userRepo;

  VeriBloc({@required UserRepo userRepo})
      : assert(userRepo!=null),
        _userRepo=userRepo, super(Comprobar());

  @override
  Stream<VeriState> mapEventToState(
      VeriEvent event
      )async*{
    if(event is Empezar){
      yield* _mapAppStartedToState();
    }
    if(event is PedirConfirmacion){
      yield* _mapPedirConfirmacionToState();
    }
  }

  Stream<VeriState> _mapAppStartedToState() async*{
    try{
      final EstaVerificado  = await _userRepo.estaVerificado();
      if(!EstaVerificado){
        yield await Verificado();
      }
      else {
        yield await NoVerificado();
      }
    } catch (_) {
      yield NoVerificado();
    }
  }

  Stream<VeriState> _mapPedirConfirmacionToState(
      ) async*{
    try {
      await _userRepo.enviarEmail();
      yield Esperando();
    } catch (_) {
      yield NoVerificado();
    }
  }

}