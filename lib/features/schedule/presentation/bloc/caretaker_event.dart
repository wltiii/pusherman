import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CaretakerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCaretaker extends CaretakerEvent {
  final String name;

  GetCaretaker({@required this.name});

  @override
  List<Object> get props => [name];
}
