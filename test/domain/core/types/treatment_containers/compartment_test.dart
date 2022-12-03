import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/compartment.dart';
import 'package:unrepresentable_state/unrepresentable_state.dart';

import '../../../../test_utills/abstract_object_builders.dart';

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

  final givenOtherDependent = Dependent(
    LoginId(givenOtherDependentIdValue),
    DependentName(givenOtherDependentNameValue),
  );

  final givenCaregiver = CareGiver(
    LoginId(givenCaregiverIdValue),
    DependentName(givenCaregiverNameValue),
  );

  final givenOtcDescription = ConcreteTreatmentDescription(givenOtcDescriptionValue);
  final givenOtcDirections = ConcreteTreatmentDirections(givenOtcDirectionsValue);
  final givenSupplementDescription = ConcreteTreatmentDescription(givenSupplementDescriptionValue);
  final givenSupplementDirections = ConcreteTreatmentDirections(givenSupplementDirectionsValue);

  final givenTreatment = ConcreteTreatment(
    givenDependent,
    givenCaregiver,
    givenSupplementDescription,
    givenSupplementDirections,
  );

  final givenAnotherTreatment = ConcreteTreatment(
    givenDependent,
    givenCaregiver,
    givenOtcDescription,
    givenOtcDirections,
  );

  final givenTreatmentForOtherDependent = ConcreteTreatment(
    givenOtherDependent,
    givenCaregiver,
    givenSupplementDescription,
    givenSupplementDirections,
  );

  group('construction', () {
    group('success cases', () {
      test('instantiates with no treatments', () {
        final compartment = Compartment(
          // givenDependent,
          // givenCaregiver,
          const <Treatment>[],
        );

        // expect(compartment, isA<Equatable>());
        expect(compartment.list.isEmpty, isTrue);
        expect(compartment.dependentName.isEmpty, isTrue);
        expect(compartment.caregiverName.isEmpty, isTrue);
      });

      test('instantiates with one treatment', () {
        final compartment = Compartment(
          // givenDependent,
          // givenCaregiver,
          [givenTreatment],
        );

        // expect(compartment, isA<Equatable>());
        expect(compartment.list, equals([givenTreatment]));
        expect(compartment.dependentName, equals(givenDependentNameValue));
        expect(compartment.caregiverName, equals(givenCaregiverNameValue));
      });

      test('instantiates with multiple treatments', () {
        final compartment = Compartment(
          // givenDependent,
          // givenCaregiver,
          <Treatment>[givenTreatment, givenAnotherTreatment],
        );

        // expect(compartment, isA<Equatable>());
        expect(
          compartment.list.length,
          equals(2),
        );
        expect(
          compartment.list.contains(givenTreatment),
          isTrue,
        );
        expect(
          compartment.list.contains(givenAnotherTreatment),
          isTrue,
        );
        expect(compartment.dependentName, equals(givenDependentNameValue));
        expect(compartment.caregiverName, equals(givenCaregiverNameValue));
      });
    });

    group('exception cases', () {
      test('exception thrown when treatments duplicated', () {
        expect(
          () => Compartment(
            // givenDependent,
            // givenCaregiver,
            <Treatment>[
              givenTreatment,
              givenTreatment,
            ],
          ),
          throwsA(
            predicate(
              (e) =>
                  e is ValueException &&
                  e.message == 'Invalid value. Treatment list contains duplicates.',
            ),
          ),
        );
      });

      test('exception thrown when dependent or caregiver are inconsistent', () {
        expect(
          () => Compartment(
            // givenDependent,
            // givenCaregiver,
            <Treatment>[givenTreatment, givenTreatmentForOtherDependent],
          ),
          throwsA(
            predicate(
              (e) =>
                  e is ValueException &&
                  e.message ==
                      'Invalid value. One or more treatments do not'
                          ' have the same dependent or caregiver.',
            ),
          ),
        );
      });
    });
  });

  group('treatment list order', () {
    final givenTreatment1 = ConcreteTreatment(
      givenOtherDependent,
      givenCaregiver,
      ConcreteTreatmentDescription('treatment-1'),
      ConcreteTreatmentDirections('adDirection'),
    );

    final givenTreatment2 = ConcreteTreatment(
      givenOtherDependent,
      givenCaregiver,
      ConcreteTreatmentDescription('treatment-2'),
      ConcreteTreatmentDirections('adDirection'),
    );

    test('compartments with same values in same order are equal', () {
      final compartment = Compartment(
        <Treatment>[givenTreatment1, givenTreatment2],
      );

      expect(
        compartment.list,
        equals(
          [givenTreatment1, givenTreatment2],
        ),
      );
    });

    test('compartments with same values in different orders are equal', () {
      final compartment = Compartment(
        // givenDependent,
        // givenCaregiver,
        <Treatment>[givenTreatment2, givenTreatment1],
      );

      expect(
        compartment.list,
        equals(
          [givenTreatment1, givenTreatment2],
        ),
      );
    });
  });

  // TODO implement toString tests if not already in place above
  /*
  group('toString', () {
    test('returns string', () {
      final compartment = TreatmentBox(
        // givenDependent,
        // givenCaregiver,
        <Treatment>[givenTreatment, givenAnotherTreatment],
      );

      expect(
        compartment.toString(),
        equals(
          'ConcreteTreatment('
          '$givenDependent'
          ', $givenCaregiver'
          // ', $givenTreatmentDescription'
          // ', $givenTreatmentDirections'
          ')',
        ),
      );
    });
  });

   */
}
