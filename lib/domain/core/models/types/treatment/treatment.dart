import 'package:equatable/equatable.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/value_objects/exception_message.dart';

import '../../value_objects/non_empty_string.dart';

///
/// A [Treatment] can take many forms: pills, topicals, physical activity,
/// psychological or brain exercises, etc.
///
/// A [Treatment] is used/performed by the [Dependent]. An optional
/// [Caregiver] can be added to monitor [Treatment] activity. If
/// [Caregiver] is not specified, the [Caregiver] is set to the
/// [Dependent].
///
/// See also:
/// [User], [Dependent], [Caregiver], [TreatmentDescription]
/// and [TreatmentDirections]
///
abstract class Treatment extends Equatable {
  Treatment(
    Dependent dependent,
    Caregiver? caregiver,
    TreatmentDescription treatmentDescription,
    TreatmentDirections treatmentDirections,
  ) {
    _dependent = dependent;
    _caregiver = caregiver ??
        Caregiver(
          UserId(dependent.id),
          UserName(dependent.name),
        );
    _treatmentDescription = treatmentDescription;
    _treatmentDirections = treatmentDirections;
  }

  late final Dependent _dependent;
  late final Caregiver _caregiver;
  late final TreatmentDescription _treatmentDescription;
  late final TreatmentDirections _treatmentDirections;

  Dependent get dependent => _dependent;
  Caregiver get caregiver => _caregiver;
  String get description => _treatmentDescription.value;
  String get directions => _treatmentDirections.value;
  bool get caregiverIsDependent =>
      _caregiver ==
      Caregiver(
        UserId(dependent.id),
        UserName(dependent.name),
      );

  @override
  List get props => <dynamic>[
        _dependent,
        _caregiver,
        _treatmentDescription,
        _treatmentDirections,
      ];

  @override
  bool get stringify => true;
}

class TreatmentDescription extends NonEmptyString {
  TreatmentDescription(String value)
      : super(
          value,
          validators: [
            (String value) => {
                  if (value.trimRight().isEmpty)
                    throw ValueException(
                      ExceptionMessage(
                        'Description must not be empty.',
                      ),
                    ),
                },
          ],
        );
}

class TreatmentDirections extends NonEmptyString {
  TreatmentDirections(String value)
      : super(
          value,
          validators: [
            (String value) => {
                  if (value.trimRight().isEmpty)
                    throw ValueException(
                      ExceptionMessage(
                        'Directions must not be empty.',
                      ),
                    ),
                },
          ],
        );
}
