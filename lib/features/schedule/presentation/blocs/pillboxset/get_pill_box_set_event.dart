import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pusherman/features/schedule/presentation/blocs/pillboxset/pill_box_set_event.dart';

class GetPillBoxSetForDependentEvent extends PillBoxSetEvent {
  final String dependent;

  // TODO null safely will allow input to be null - tiernary not needed
  factory GetPillBoxSetForDependentEvent(String? input) =>
      input == null
          ? GetPillBoxSetForDependentEvent._('')
          : GetPillBoxSetForDependentEvent._(input);

  GetPillBoxSetForDependentEvent._(this.dependent);

  @override
  List<Object> get props => [dependent];
}