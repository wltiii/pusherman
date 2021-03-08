import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Caretaker extends Equatable {
  final String name;
  final List<String> dependents;

  Caretaker({
    required this.name,
    required this.dependents
  });

  @override
  List<Object> get props => [name, dependents];

  @override
  bool get stringify => true;
}