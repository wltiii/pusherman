import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:pusherman/features/schedule/domain/entities/caretaker.dart';

abstract class CaretakerState extends Equatable {
  // const CaretakerState();
  @override
  List<Object> get props => [];
}

// class CaretakerInitial extends CaretakerState {
//   @override
//   List<Object> get props => [];
// }

class CaretakerEmpty extends CaretakerState {}

class CaretakerLoading extends CaretakerState {}

class CaretakerLoaded extends CaretakerState {
  final Caretaker caretaker;

  CaretakerLoaded({ @required this.caretaker });

  @override
  List<Object> get props => [caretaker];
}
class CaretakerError extends CaretakerState {
  final String message;

  CaretakerError({ @required this.message });

  @override
  List<Object> get props => [message];
}
