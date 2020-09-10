import 'package:equatable/equatable.dart';

abstract class AutEvent extends Equatable{
  const AutEvent();

  @override
  List<Object> get props => [];
}

//Eventos

//App Started
class AppStarted extends AutEvent{}

//Loguearse
class LoggedIn extends AutEvent{}

//Desloguearse
class LoggedOut extends AutEvent{}