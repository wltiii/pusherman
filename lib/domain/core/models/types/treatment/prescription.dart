import 'package:json_annotation/json_annotation.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';
import 'package:pusherman/domain/core/models/value_objects/natural_number.dart';
import 'package:pusherman/domain/core/models/value_objects/whole_number.dart';

/// A [Prescription] is a medication used to treat an ailment. It
/// requires a prescription.
///
/// It can take many forms: pills, topicals, liquids, etc.
///
/// See also:
/// [Treatment], [User], [PrescriptionDescription], [PrescriptionDirections],
/// [PrescriptionRefillQuantity] and [PrescriptionOnHandQuantity].
///tion description,
    PrescriptionDirections directions,
    this._prescriptionRefillQuantityQuantity,
    this._prescriptionOnHandQuantity,
  ) : super(
          dependent,
          caregiver,
          description,
          directions,
        );

  final PrescriptionRefillQuantity _prescriptionRefillQuantityQuantity;
  final PrescriptionOnHandQuantity _prescriptionOnHandQuantity;

  int get refillQuantity => _prescriptionRefillQuantityQuantity.value;

  int get onHandQuantity => _prescriptionOnHandQuantity.value;

  @override
  List get props => super.props
    ..addAll(
      <dynamic>[
        _prescriptionRefillQuantityQuantity,
        _prescriptionOnHandQuantity,
      ],
    )
    ..toList();
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
