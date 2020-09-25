import 'package:equatable/equatable.dart';

abstract class PuntEvent extends Equatable {
  const PuntEvent();

  @override
  List<Object> get props => [];
}

class LoadPunt extends PuntEvent {}
