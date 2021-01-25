import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class PillBoxSetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPillBoxSetForDependent extends PillBoxSetEvent {
  final String dependent;

  factory GetPillBoxSetForDependent(String input) =>
      input == null
          ? GetPillBoxSetForDependent._('')
          : GetPillBoxSetForDependent._(input);
  // GetPillBoxSetForDependent({this.dependent});
  GetPillBoxSetForDependent._(this.dependent);
  // GetPillBoxSetForDependent(this.dependent);

  /*
  static final InputConverter _instance = InputConverter._();

  factory InputConverter() => _instance;

  InputConverter._() { }
   */

  @override
  List<Object> get props => [dependent];
}
