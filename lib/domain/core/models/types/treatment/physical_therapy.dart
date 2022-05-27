import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';
import 'package:pusherman/domain/core/models/value_objects/natural_number.dart';

/// A [PhysicalTherapy] is a type of [Treatment] that defines a an activity
/// used to improve the state of being.
///
///
/// See also:
/// [Treatment], [User], [PhysicalTherapyDescription] and
/// [PhysicalTherapyDirections]
///
class PhysicalTherapy extends Treatment {
  PhysicalTherapy(
    Dependent dependent,
    Caregiver? caregiver,
    PhysicalTherapyDescription description,
    PhysicalTherapyDirections directions,
    this._physicalTherapyRepititions,
  ) : super(
          dependent,
          caregiver,
          description,
          directions,
        );

  final PhysicalTherapyRepetitions _physicalTherapyRepititions;
  int get repetitions => _physicalTherapyRepititions.value;

  @override
  List get props => super.props
    ..add(_physicalTherapyRepititions)
    ..toList();
}

class PhysicalTherapyDescription extends TreatmentDescription {
  PhysicalTherapyDescription(String value) : super(value);
}

class PhysicalTherapyDirections extends TreatmentDirections {
  PhysicalTherapyDirections(String value) : super(value);
}

class PhysicalTherapyRepetitions extends NaturalNumber {
  PhysicalTherapyRepetitions(int value) : super(value);
}
