import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SetupState extends Equatable {
  const SetupState();

  @override
  List<Object> get props => [];
}

// class CurrentIndexChanged extends BottomNavigationState {
//   final int currentIndex;
//
//   CurrentIndexChanged({@required this.currentIndex});
//
//   @override
//   String toString() => 'CurrentIndexChanged to $currentIndex';
// }

class SetupInitialState extends SetupState {}

class SetupLoading extends SetupState {
  @override
  String toString() => 'SetupLoading';
}

class FirstPageLoaded extends SetupState {
  final String text;

  FirstPageLoaded({@required this.text});

  @override
  String toString() => 'FirstPageLoaded with text: $text';
}

class SecondPageLoaded extends SetupState {
  final int number;

  SecondPageLoaded({@required this.number});

  @override
  String toString() => 'SecondPageLoaded with number: $number';
}