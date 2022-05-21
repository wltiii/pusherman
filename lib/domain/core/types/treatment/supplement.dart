import 'package:pusherman/domain/core/types/auth/user.dart';
import 'package:pusherman/domain/core/types/treatment/treatment.dart';
import 'package:pusherman/domain/core/value_objects/natural_number.dart';
import 'package:pusherman/domain/core/value_objects/whole_number.dart';

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
class Supplement extends Treatment {
  Supplement(
    Dependent dependent,
    Caregiver? caregiver,
    SupplementDescription description,
    SupplementDirections directions,
    this._supplementRefillQuantity,
    this._supplementOnHandQuantity,
  ) : super(
          dependent,
          caregiver,
          description,
          directions,
        );

  final SupplementRefillQuantity _supplementRefillQuantity;
  final SupplementOnHandQuantity _supplementOnHandQuantity;

  int get refillQuantity => _supplementRefillQuantity.value;
  int get onHandQuantity => _supplementOnHandQuantity.value;

  @override
  List get props => super.props
    ..addAll(
      <dynamic>[
        _supplementRefillQuantity,
        _supplementOnHandQuantity,
      ],
    )
    ..toList();
}

class SupplementDescription extends TreatmentDescription {
  SupplementDescription(String value) : super(value);
}

class SupplementDirections extends TreatmentDirections {
  SupplementDirections(String value) : super(value);
}

class SupplementRefillQuantity extends NaturalNumber {
  SupplementRefillQuantity(int value) : super(value);
}

class SupplementOnHandQuantity extends WholeNumber {
  SupplementOnHandQuantity(int value) : super(value);
}
