import 'package:arcade/sauce/repository/User_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';
import 'package:meta/meta.dart';

class AutBloc extends Bloc<AutEvent, AutState>{
  final UserRepo _userRepo;

  AutBloc({@required UserRepo userRepo})
    : assert(userRepo!=null),
    _userRepo=userRepo, super(NoInicializado());

  @override
  Stream<AutState> mapEventToState(
      AutEvent event
  )async*{
    if(event is AppStarted){
      yield* _mapAppStartedToState();
    }
    if(event is LoggedIn){
      yield* _mapLoggedInToState();
    }
    if(event is LoggedOut){
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AutState> _mapAppStartedToState() async*{
    try{
      final EstaLogueado  = await _userRepo.estaLogueado();
      if(EstaLogueado){
        final user = await _userRepo.obUsuario();
        yield await Future.delayed(Duration(seconds: 5), (){
          return Autenticado(user);
        });
      }
      else {
        yield await Future.delayed(Duration(seconds: 5), (){
          return NoAutenticado();
        });
      }
    } catch (_) {
      yield NoAutenticado();
    }
  }

  Stream<AutState> _mapLoggedInToState() async* {
    yield Autenticado(await _userRepo.obUsuario());
  }

  Stream<AutState> _mapLoggedOutToState() async*{
    yield NoAutenticado();
    _userRepo.signOut();
  }
}