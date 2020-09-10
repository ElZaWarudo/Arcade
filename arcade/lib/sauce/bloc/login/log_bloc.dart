import 'package:bloc/bloc.dart';
import 'bloc.dart';
import 'package:arcade/util/validators.dart';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:arcade/sauce/repository/User_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepo _userRepo;

  //Constructor
  LoginBloc({@required UserRepo userRepo})
      : assert(userRepo != null),
        _userRepo= userRepo, super(LoginState.empty());


  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
      Stream<LoginEvent> events,
      TransitionFunction<LoginEvent, LoginState> transitionFn,
      ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });

    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));

    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event,
      ) async* {
    if(event is EmailChanged){
      yield* _mapEmailChangedToState(event.email);
    }
    if(event is PasswordChanged){
      yield* _mapPasswordChangedToState(event.password);
    }
    if(event is LoginWithGooglePressed){
      yield* _mapLoginWithGooglePressedToState();
    }
    if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email,
          password: event.password
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async*{
    yield state.update(
        isEmailValid: Validators.isValidEmail(email)
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async*{
    yield state.update(
        isPasswordValid: Validators.isValidPassword(password)
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async*{
    try {
      await _userRepo.LoginConGoogle();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email, String password
  }) async* {
    yield LoginState.loading();
    try {
      await _userRepo.signIn(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}