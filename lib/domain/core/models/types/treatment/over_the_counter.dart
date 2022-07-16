import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';

/// A [OverTheCounter] is a medication used to treat an ailment. It does not
/// require a prescription.
///
/// It can take many forms: pills, topicals, liquids, etc.
///
/// See also:
/// [Treatment], [User], [OverTheCounterDescription] and
/// [OverTheCounterDirections].
///
part 'over_the_counter.g.dart';

@JsonSerializable(explicitToJson: true)
class OverTheCounter extends Treatment {
  OverTheCounter(
    Dependent dependent,
    CareGiver? caregiver,
    OverTheCounterDescription description,
    OverTheCounterDirections directions,
  ) : super(
          dependent,
          caregiver,
          description,
          directions,
        );
}

class OverTheCounterDescription extends TreatmentDescription {
  OverTheCounterDescription(String value) : super(value);
}

class OverTheCounterDirections extends TreatmentDirections {
  OverTheCounterDirections(String value) : super(value);
}