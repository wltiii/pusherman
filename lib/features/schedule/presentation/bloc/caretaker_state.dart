import 'package:equatable/equatable.dart';

abstract class CaretakerState extends Equatable {
  const CaretakerState();
}

class CaretakerInitial extends CaretakerState {
  @override
  List<Object> get props => [];
}
