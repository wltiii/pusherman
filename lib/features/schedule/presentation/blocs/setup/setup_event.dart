import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class SetupEvent extends Equatable {
  const SetupEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends SetupEvent {
  @override
  String toString() => 'AppStarted';
}

class PageTapped extends SetupEvent {
  final int index;

  PageTapped({ @required this.index });

  @override
  String toString() => 'PageTapped: $index';
}