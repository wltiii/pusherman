import 'package:json_annotation/json_annotation.dart';
import 'package:unrepresentable_state/unrepresentable_state.dart';

part 'number_of_compartments.g.dart';

@JsonSerializable()
class NumberOfCompartments extends NaturalNumber {
  NumberOfCompartments(int value) : super(value);
}
