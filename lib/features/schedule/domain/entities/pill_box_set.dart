import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'pill_box.dart';

class PillBoxSet extends Equatable {
  final String dependent;
  final List<String> caretakers;
  final List<PillBox> pillBoxes;

  PillBoxSet({
    required this.dependent,
    required this.caretakers,
    required this.pillBoxes,
  });

  @override
  List<Object> get props => [dependent, caretakers, pillBoxes];

  @override
  bool get stringify => true;
}