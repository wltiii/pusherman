import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';

class ConcreteTreatment extends Treatment {
  ConcreteTreatment(
    Dependent dependent,
    CareGiver? caregiver,
    TreatmentDescription description,
    TreatmentDirections directions,
  ) : super(
          dependent,
          caregiver,
          description,
          directions,
        );
}

class ConcreteTreatmentDescription extends TreatmentDescription {
  ConcreteTreatmentDescription(String value) : super(value);
}

class ConcreteTreatmentDirections extends TreatmentDirections {
  ConcreteTreatmentDirections(String value) : super(value);
}
