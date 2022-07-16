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
///cription,
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
