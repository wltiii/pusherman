import 'package:json_annotation/json_annotation.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';
import 'package:pusherman/domain/core/models/value_objects/natural_number.dart';
import 'package:pusherman/domain/core/models/value_objects/whole_number.dart';

/// A [Supplement] is a type of [Treatment] that defines an activity
/// used to improve the state of being.
///
/// It can take many forms: pills, topicals, liquids, etc.
///
/// See also:
/// [Treatment], [User], [SupplementDescription], [SupplementDirections],
/// [SupplementRefillQuantity] and [SupplementOnHandQuantity].
///
// TODO(wltiii): Prescription and Supplement are currently exactly the same.
// TODO(wltiii): Perhaps extend from a common abstraction. NOTE:
// TODO(wltiii): I expect them to diverge in the future.
part 'supplement.g.dart';

@JsonSerializable(explicitToJson: true)
class Supplement extends Treatment {
  Supplement(
    Dependent dependent,
    CareGiver? caregiver,
    SupplementDescription description,
    SupplementDirections directions,
    SupplementRefillQuantity supplementRefillQuantity,
    SupplementOnHandQuantity supplementOnHandQuantity,
  ) : super(
          dependent,
          caregiver,
          description,
          directions,
        ) {
    _supplementRefillQuantity = supplementRefillQuantity;
    _supplementOnHandQuantity = supplementOnHandQuantity;
  }

  late final SupplementRefillQuantity _supplementRefillQuantity;
  late final SupplementOnHandQuantity _supplementOnHandQuantity;

  int get refillQuantity => _supplementRefillQuantity.value;

  int get onHandQuantity => _supplementOnHandQuantity.value;

  /// Connect the generated [_$SupplementFromJson] function to the `fromJson`
  /// factory.
  factory Supplement.fromJson(Map<String, dynamic> json) =>
      _$SupplementFromJson(json);

  /// Connect the generated [_$SupplementToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SupplementToJson(this);

  //TODO(wltiii): get props seems to beg to be generated
  @override
  List get props => super.props
    ..addAll(
      <dynamic>[
        _supplementRefillQuantity,
        _supplementOnHandQuantity,
      ],
    )
    ..toList();

  //TODO(wltiii): most definitely this should be generated
  @override
  bool get stringify => true;
}

class SupplementDescription extends TreatmentDescription {
  SupplementDescription(String value) : super(value);
}

class SupplementDirections extends TreatmentDirections {
  SupplementDirections(String value) : super(value);
}

class SupplementOnHandQuantity extends WholeNumber {
  SupplementOnHandQuantity(int value) : super(value);
}

class SupplementRefillQuantity extends NaturalNumber {
  SupplementRefillQuantity(int value) : super(value);
}