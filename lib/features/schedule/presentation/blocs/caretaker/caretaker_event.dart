import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CaretakerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CaretakerGetEvent extends CaretakerEvent {
  final String name;

  CaretakerGetEvent({ @required this.name });

  @override
  List<Object> get props => [name];
}
