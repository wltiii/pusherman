import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class PillBoxSetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPillBoxSetForDependent extends PillBoxSetEvent {
  final String dependent;

  // TODO why is this using a standard constructor rather than named?
  // GetPillBoxSetGetEvent({@required this.dependent});
  GetPillBoxSetForDependent(this.dependent);

  @override
  List<Object> get props => [dependent];
}
