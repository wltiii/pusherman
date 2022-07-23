import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';
import 'package:pusherman/domain/core/models/value_objects/natural_number.dart';
import 'package:pusherman/domain/core/models/value_objects/whole_number.dart';

import '../type_defs.dart';

part 'prescription.freezed.dart';
part 'prescription.g.dart';

/// A [Prescription] is a medication used to treat an ailment. It
/// requires a prescription.
///
/// It can take many forms: pills, topicals, liquids, etc.
///
/// See also:
/// [Treatment], [User], [PrescriptionDescription], [PrescriptionDirections],
/// [PrescriptionRefillQuantity] and [PrescriptionOnHandQuantity].
///
// TODO(wltiii): Prescription and Supplement are currently exactly the same.
// TODO(wltiii): Perhaps extend from a common abstraction. NOTE:
// TODO(wltiii): I expect them to diverge in the future.
@JsonSerializable(explicitToJson: true)
@freezed
class Prescription extends Treatment with _$Prescription {
  const Prescription._();

  const factory Prescription(
    Dependent dependent,
    CareGiver? caregiver,
    PrescriptionDescription description,
    PrescriptionDirections directions,
    PrescriptionRefillQuantity prescriptionRefillQuantity,
    PrescriptionOnHandQuantity prescriptionOnHandQuantity,
  ) = _Prescription;

  // Prescription(
  //   Dependent dependent,
  //   CareGiver? caregiver,
  //   PrescriptionDescription description,
  //   PrescriptionDirections directions,
  //   PrescriptionRefillQuantity prescriptionRefillQuantity,
  //   PrescriptionOnHandQuantity prescriptionOnHandQuantity,
  // ) : super(
  //         dependent,
  //         caregiver,
  //         description,
  //         directions,
  //       ) {
  //   _prescriptionRefillQuantity = prescriptionRefillQuantity;
  //   _prescriptionOnHandQuantity = prescriptionOnHandQuantity;
  // }
  //
  // late final PrescriptionRefillQuantity _prescriptionRefillQuantity;
  // late final PrescriptionOnHandQuantity _prescriptionOnHandQuantity;

  // int get refillQuantity => _prescriptionRefillQuantity.value;
  int get refillQuantity => prescriptionRefillQuantity.value;

  // int get onHandQuantity => _prescriptionOnHandQuantity.value;
  int get onHandQuantity => prescriptionOnHandQuantity.value;

  /// Connect the generated [_$PrescriptionFromJson] function to the `fromJson`
  /// factory.
  factory Prescription.fromJson(Json json) =>
      _$PrescriptionFromJson(json);

  // /// Connect the generated [_$PrescriptionToJson] function to the `toJson` method.
  // Map<String, dynamic> toJson() => _$PrescriptionToJson(this);
  //
  // //TODO(wltiii): get props seems to beg to be generated
  // @override
  // List get props => super.props
  //   ..addAll(
  //     <dynamic>[
  //       _prescriptionRefillQuantity,
  //       _prescriptionOnHandQuantity,
  //     ],
  //   )
  //   ..toList();
  //
  // //TODO(wltiii): most definitely this should be generated
  // @override
  // bool get stringify => true;
}

class PrescriptionDescription extends TreatmentDescription {
  PrescriptionDescription(String value) : super(value);
}

class PrescriptionDirections extends TreatmentDirections {
  PrescriptionDirections(String value) : super(value);
}

class PrescriptionRefillQuantity extends NaturalNumber {
  PrescriptionRefillQuantity(int value) : super(value);
}

class PrescriptionOnHandQuantity extends WholeNumber {
  PrescriptionOnHandQuantity(int value) : super(value);
}