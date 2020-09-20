import 'package:arcade/util/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:arcade/sauce/bloc/register/reg.state.dart';
import 'package:arcade/sauce/bloc/register/reg_event.dart';
import 'package:arcade/sauce/repository/User_Repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class RegBloc extends Bloc<RegisterEvent, RegState> {
  final UserRepo _userRepo;

  RegBloc({@required UserRepo userRepo})
      : assert(userRepo != null),
        _userRepo = userRepo, super(RegState.empty());


  @override
  Stream<Transition<RegisterEvent, RegState>> transformEvents(
      Stream<RegisterEvent> events,
      TransitionFunction<RegisterEvent, RegState> transitionFn,
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
  Stream<RegState> mapEventToState(
      RegisterEvent event,
      ) async* {
    // Tres casos
    // Si el evento es EmailChanged
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    }
    // Si el evento es PasswordChanged
    if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    }
    // Si el evento es Submitted
    if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password);
    }
  }

  Stream<RegState> _mapEmailChangedToState(String email) async*{
    yield state.update(
        isEmailValid: Validators.isValidEmail(email)
    );
  }

  Stream<RegState> _mapPasswordChangedToState(String password) async*{
    yield state.update(
        isPasswordValid: Validators.isValidPassword(password)
    );
  }

  Stream<RegState> _mapFormSubmittedToState(
      String email, String password
      ) async*{
    yield RegState.loading();
    try {
      await _userRepo.signUp(email, password);
      yield RegState.success();
    } catch (_) {
      yield RegState.failure();
    }
  }

}