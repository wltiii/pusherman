import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';

abstract class PillBoxSetState extends Equatable {
  @override
  List<Object> get props => [];
}

class PillBoxSetInitial extends PillBoxSetState {
  @override
  List<Object> get props => [];
}

class Empty extends PillBoxSetState {}

class Loading extends PillBoxSetState {}

class Loaded extends PillBoxSetState {
  final PillBoxSet pillBoxSet;

  Loaded({@required this.pillBoxSet});

  @override
  List<Object> get props => [pillBoxSet];
}
class Error extends PillBoxSetState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
