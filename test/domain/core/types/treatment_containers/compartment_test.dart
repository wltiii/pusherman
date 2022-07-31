import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/over_the_counter.dart';
import 'package:pusherman/domain/core/models/types/treatment/supplement.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/compartment.dart';

class AbstractTreatmentTester extends Treatment {
  AbstractTreatmentTester(
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
  const givenRefillQuantityValue = 42;
  const givenOnHandQuantityValue = 23;

  final givenDependent = Dependent(
    UserId(givenDependentIdValue),
    UserName(givenDependentNameValue),
  );

  final givenOtherDependent = Dependent(
    UserId(givenOtherDependentIdValue),
    UserName(givenOtherDependentNameValue),
  );

  final givenCaregiver = CareGiver(
    UserId(givenCaregiverIdValue),
    UserName(givenCaregiverNameValue),
  );

  final givenOtcDescription =
      OverTheCounterDescription(givenOtcDescriptionValue);
  final givenOtcDirections = OverTheCounterDirections(givenOtcDirectionsValue);
  final givenSupplementDescription =
      SupplementDescription(givenSupplementDescriptionValue);
  final givenSupplementDirections =
      SupplementDirections(givenSupplementDirectionsValue);
  final givenTreatmentRefillQuantity =
      SupplementRefillQuantity(givenRefillQuantityValue);
  final givenTreatmentOnHandQuantity =
      SupplementOnHandQuantity(givenOnHandQuantityValue);

  final givenTreatment = AbstractTreatmentTester(
    givenDependent,
    givenCaregiver,
    givenSupplementDescription,
    givenSupplementDirections,
  );
  // final givenTreatment = Supplement(
  //   givenDependent,
  //   givenCaregiver,
  //   givenSupplementDescription,
  //   givenSupplementDirections,
  //   givenTreatmentRefillQuantity,
  //   givenTreatmentOnHandQuantity,
  // );

  final givenAnotherTreatment = AbstractTreatmentTester(
    givenDependent,
    givenCaregiver,
    givenSupplementDescription,
    givenSupplementDirections,
  );
  // final givenAnotherTreatment = OverTheCounter(
  //   givenDependent,
  //   givenCaregiver,
  //   givenOtcDescription,
  //   givenOtcDirections,
  // );

  final givenTreatmentForOtherDependent = AbstractTreatmentTester(
    givenOtherDependent,
    givenCaregiver,
    givenSupplementDescription,
    givenSupplementDirections,
  );
  // final givenTreatmentForOtherDependent = OverTheCounter(
  //   givenOtherDependent,
  //   givenCaregiver,
  //   givenOtcDescription,
  //   givenOtcDirections,
  // );

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
                  e.message ==
                      'Invalid value. Treatment list contains duplicates.',
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
    final givenTreatment1 = OverTheCounter(
      givenOtherDependent,
      givenCaregiver,
      OverTheCounterDescription('treatment-1'),
      OverTheCounterDirections('adDirection'),
    );

    final givenTreatment2 = OverTheCounter(
      givenOtherDependent,
      givenCaregiver,
      OverTheCounterDescription('treatment-2'),
      OverTheCounterDirections('adDirection'),
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
          'AbstractTreatmentTester('
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
