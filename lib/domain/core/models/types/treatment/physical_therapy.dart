import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';
import 'package:pusherman/domain/core/models/value_objects/natural_number.dart';

import '../type_defs.dart';

part 'physical_therapy.freezed.dart';
part 'physical_therapy.g.dart';

/// A [PhysicalTherapy] is a type of [Treatment] that defines a an activity
/// used to improve the state of being.
///
///
/// See also:
/// [Treatment], [User], [PhysicalTherapyDescription],
/// [PhysicalTherapyDirections] and [PhysicalTherapyRepetitions]
///
@JsonSerializable(explicitToJson: true)
@freezed
class PhysicalTherapy extends Treatment with _$PhysicalTherapy {
  const PhysicalTherapy._();

  factory PhysicalTherapy(
    Dependent dependent,
    CareGiver? caregiver,
    PhysicalTherapyDescription description,
    PhysicalTherapyDirections directions,
      // PhysicalTherapyRepetitions _physicalTherapyRepititions,
      PhysicalTherapyRepetitions physicalTherapyRepititions,
  ) : super(
          dependent,
          caregiver,
          description,
          directions,
        ) = _PhysicalTherapy;
  // PhysicalTherapy(
  //   Dependent dependent,
  //   CareGiver? caregiver,
  //   PhysicalTherapyDescription description,
  //   PhysicalTherapyDirections directions,
  //     PhysicalTherapyRepetitions physicalTherapyRepititions,
  // ) : super(
  //         dependent,
  //         caregiver,
  //         description,
  //         directions,
  //       ) {
  //   _physicalTherapyRepititions = physicalTherapyRepititions;
  // }

  // late final PhysicalTherapyRepetitions _physicalTherapyRepititions;
  // late final PhysicalTherapyRepetitions _physicalTherapyRepititions;

  int get repetitions => physicalTherapyRepititions.value;

  /// Connect the generated [_$PhysicalTherapyFromJson] function to the `fromJson`
  /// factory.
  factory PhysicalTherapy.fromJson(Json json) =>
      _$PhysicalTherapyFromJson(json);

// @override
  // List get props => super.props
  //   ..add(_physicalTherapyRepititions)
  //   ..toList();
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