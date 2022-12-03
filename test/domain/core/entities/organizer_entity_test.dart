import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/entities/entity.dart';
import 'package:pusherman/domain/core/entities/organizer_entity.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/compartment.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/organizer.dart';
import 'package:unrepresentable_state/unrepresentable_state.dart';

import '../../../test_utills/abstract_object_builders.dart';

void main() {
  const givenDependentIdValue = 'abc123';
  const givenDependentNameValue = 'aUserName';
  const givenCaregiverIdValue = 'caregiver789';
  const givenCaregiverNameValue = 'aCaregiverName';
  const givenOtcDescriptionValue = 'aOtcDescription';
  const givenOtcDirectionsValue = 'aOtcDirections';
  const givenOtherDependentIdValue = 'otherDependentId';
  const givenOtherDependentNameValue = 'otherDependName';
  const givenSupplementDescriptionValue = 'aSupplementDescription';
  const givenSupplementDirectionsValue = 'aSupplementDirections';
  // const givenRefillQuantityValue = 42;
  // const givenOnHandQuantityValue = 23;

  final givenDependent = Dependent(
    LoginId(givenDependentIdValue),
    DependentName(givenDependentNameValue),
  );

  final givenCaregiver = CareGiver(
    LoginId(givenCaregiverIdValue),
    DependentName(givenCaregiverNameValue),
  );

  final givenOtcDescription = ConcreteTreatmentDescription(givenOtcDescriptionValue);
  final givenOtcDirections = ConcreteTreatmentDirections(givenOtcDirectionsValue);

  group('construction', () {
    test('from default', () {
      final id = OrganizerEntityId('anId');
      final path = OrganizerEntityPath('aPath');
      final metaData = OrganizerEntityMetaData(id: id, path: path);
      final givenTreatment = ConcreteTreatment(
        givenDependent,
        givenCaregiver,
        givenOtcDescription,
        givenOtcDirections,
      );

      final orgName = OrganizerName('orgName');
      final frequency = OrganizerFrequency('orgFrequency');
      final compartment = Compartment(<Treatment>[givenTreatment]);
      final compartmentCount = NumberOfCompartments(7);

      final model = Organizer(
        name: orgName,
        frequency: frequency,
        compartment: compartment,
        numberOfCompartments: compartmentCount,
      );
      final organizerEntity = OrganizerEntity(
        entityMetaData: metaData,
        model: model,
      );

      expect(organizerEntity, isA<Entity>());
    });
  });
}
