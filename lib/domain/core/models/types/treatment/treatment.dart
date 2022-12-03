import 'package:equatable/equatable.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:unrepresentable_state/unrepresentable_state.dart';

///
/// A [Treatment] can take many forms: pills, topicals, physical activity,
/// psychological or brain exercises, etc.
///
/// A [Treatment] is used/performed by the [Dependent]. An optional
/// [CareGiver] can be added to monitor [Treatment] activity. If
/// [CareGiver] is not specified, the [CareGiver] is set to the
/// [Dependent].
///
/// See also:
/// [User], [Dependent], [CareGiver], [TreatmentDescription]
/// and [TreatmentDirections]
///

abstract class Treatment extends Equatable {
  Treatment(
    this._dependent,
    CareGiver? caregiver,
    this._treatmentDescription,
    this._treatmentDirections,
  ) {
    _caregiver = caregiver ??
        CareGiver(
          LoginId(dependent.id),
          DependentName(dependent.name),
        );
  }

  final Dependent _dependent;
  late final CareGiver _caregiver;
  final TreatmentDescription _treatmentDescription;
  final TreatmentDirections _treatmentDirections;

  Dependent get dependent => _dependent;

  CareGiver get caregiver => _caregiver;

  String get description => _treatmentDescription.value;

  String get directions => _treatmentDirections.value;

  bool get caregiverIsDependent =>
      _caregiver ==
      CareGiver(
        LoginId(dependent.id),
        DependentName(dependent.name),
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

// factory TreatmentDescription.fromJson<Json json>
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
