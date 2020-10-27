import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class PillBoxSetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPillBoxSet extends PillBoxSetEvent {
  final String dependent;

  GetPillBoxSet({@required this.dependent});

  @override
  List<Object> get props => [dependent];
}
