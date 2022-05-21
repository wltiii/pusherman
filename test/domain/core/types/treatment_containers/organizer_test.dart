import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/types/auth/user.dart';
import 'package:pusherman/domain/core/types/treatment/over_the_counter.dart';
import 'package:pusherman/domain/core/types/treatment/treatment.dart';
import 'package:pusherman/domain/core/types/treatment_containers/compartment.dart';
import 'package:pusherman/domain/core/types/treatment_containers/organizer.dart';

void main() {
  const givenOrganizerNameValue = 'anOrganizerName';
  const givenFrequencyValue = 'aFrequency';
  const givenNumberOfCompartmentsValue = 7;
  const givenDependentIdValue = 'abc123';
  const givenDependentNameValue = 'aUserName';
  const givenCaregiverIdValue = 'caregiver789';
  const givenCaregiverNameValue = 'aCaregiverName';
  const givenOtcDescriptionValue = 'aOtcDescription';
  const givenOtcDirectionsValue = 'aOtcDirections';

  final givenDependent = Dependent(
    UserId(givenDependentIdValue),
    UserName(givenDependentNameValue),
  );

  final givenCaregiver = Caregiver(
    UserId(givenCaregiverIdValue),
    UserName(givenCaregiverNameValue),
  );

  final givenOtcDescription =
      OverTheCounterDescription(givenOtcDescriptionValue);
  final givenOtcDirections = OverTheCounterDirections(givenOtcDirectionsValue);

  final givenTreatment = OverTheCounter(
    givenDependent,
    givenCaregiver,
    givenOtcDescription,
    givenOtcDirections,
  );

  final givenOrganizerName = OrganizerName(givenOrganizerNameValue);
  final givenOrganizerFrequency = OrganizerFrequency(givenFrequencyValue);
  final givenCompartment = Compartment(
    <Treatment>[givenTreatment],
  );
  final givenNumberOfCompartments =
      NumberOfCompartments(givenNumberOfCompartmentsValue);

  group('construction', () {
    test('instantiates', () {
      final organizer = Organizer(
        givenOrganizerName,
        givenOrganizerFrequency,
        givenCompartment,
        givenNumberOfCompartments,
      );

      expect(organizer, isA<Equatable>());
      expect(organizer.name, equals(givenOrganizerNameValue));
      expect(organizer.frequency, equals(givenFrequencyValue));
      expect(
        organizer.numberOfCompartments,
        equals(givenNumberOfCompartmentsValue),
      );
      expect(organizer.dependentName, equals(givenDependentNameValue));
      expect(organizer.caregiverName, equals(givenCaregiverNameValue));
    });
  });

  // Because this class extends Equatable, checking that equality
  // works should be irrelevant. We do so here anyway for it is
  // difficult to assure that all properties in a class are
  // represented.
  group('equality', () {
    final organizer = Organizer(
      givenOrganizerName,
      givenOrganizerFrequency,
      givenCompartment,
      givenNumberOfCompartments,
    );

    // TODO(wltiii): is there a better way to verify all properties are included
    test('props contains list of all properties that determine equality', () {
      expect(
        organizer.props,
        equals(<dynamic>[
          givenOrganizerName,
          givenOrganizerFrequency,
          givenCompartment,
          givenNumberOfCompartments,
        ]),
      );
    });

    test('when properties are same they are equal', () {
      // NOTE: if signature changes, unequal test may require
      // need to change or new ones added.
      final other = Organizer(
        givenOrganizerName,
        givenOrganizerFrequency,
        givenCompartment,
        givenNumberOfCompartments,
      );

      expect(organizer, equals(other));
    });
  });

  group('toString', () {
    final organizer = Organizer(
      givenOrganizerName,
      givenOrganizerFrequency,
      givenCompartment,
      givenNumberOfCompartments,
    );

    test('returns string', () {
      expect(
        organizer.toString(),
        equals(
          'Organizer('
          '$givenOrganizerName'
          ', $givenOrganizerFrequency'
          ', $givenCompartment'
          ', $givenNumberOfCompartments'
          ')',
        ),
      );
    });
  });
}
