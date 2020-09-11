part of 'jue_bloc.dart';

abstract class JueEvent extends Equatable {
  const JueEvent();

  @override
  List<Object> get props => [];
}

class LoadJue extends JueEvent {}
