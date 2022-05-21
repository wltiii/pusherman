import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/types/auth/user.dart';
import 'package:pusherman/domain/core/types/treatment/physical_therapy.dart';
import 'package:pusherman/domain/core/types/treatment/treatment.dart';

void main() {
  const givenDependentIdValue = 'abc123';
  const givenDependentNameValue = 'aUserName';
  const givenCaregiverIdValue = 'caregiver789';
  const givenCaregiverNameValue = 'aCaregiverName';
  const givenTherapyDescriptionValue = 'aPhysicalTherapyDescription';
  const givenTherapyDirectionsValue = 'aPhysicalTherapyDirections';
  const givenRepetitionValue = 42;

  final givenDependent = Dependent(
    UserId(givenDependentIdValue),
    UserName(givenDependentNameValue),
  );

  final givenCaregiver = Caregiver(
    UserId(givenCaregiverIdValue),
    UserName(givenCaregiverNameValue),
  );

  final givenRepetitions = PhysicalTherapyRepetitions(givenRepetitionValue);

  group('PhysicalTherapyDescription', () {
    test('PhysicalTherapyDescription constructs', () {
      final result = PhysicalTherapyDescription(
        givenTherapyDescriptionValue,
      );
      expect(result, isA<TreatmentDescription>());
      expect(result.value, equals(givenTherapyDescriptionValue));
    });
  });

  group('PhysicalTherapyDirections', () {
    test('PhysicalTherapyDirections constructs', () {
      final result = PhysicalTherapyDirections(givenTherapyDirectionsValue);
      expect(result, isA<TreatmentDirections>());
      expect(result.value, equals(givenTherapyDirectionsValue));
    });
  });

  group('physical therapy', () {
    final givenTreatmentDescription =
        PhysicalTherapyDescription(givenTherapyDescriptionValue);
    final givenTreatmentDirections =
        PhysicalTherapyDirections(givenTherapyDirectionsValue);

    final physicalTherapy = PhysicalTherapy(
      givenDependent,
      givenCaregiver,
      givenTreatmentDescription,
      givenTreatmentDirections,
      givenRepetitions,
    );

    group('construction', () {
      test('instantiates', () {
        expect(physicalTherapy, isA<Equatable>());
        expect(physicalTherapy, isA<Treatment>());
        expect(physicalTherapy.dependent, equals(givenDependent));
        expect(physicalTherapy.caregiver, equals(givenCaregiver));
        expect(
          physicalTherapy.description,
          equals(givenTherapyDescriptionValue),
        );
        expect(
          physicalTherapy.directions,
          equals(givenTherapyDirectionsValue),
        );
        expect(physicalTherapy.repetitions, equals(givenRepetitionValue));
      });
    });

    // Because this class extends Equatable, checking that equality
    // works should be irrelevant. We do so here anyway for it is
    // difficult to assure that all properties in a class are
    // represented.
    group('equality', () {
      test('props contains list of all properties that determine equality', () {
        expect(
          physicalTherapy.props,
          equals(<dynamic>[
            givenDependent,
            givenCaregiver,
            givenTreatmentDescription,
            givenTreatmentDirections,
            givenRepetitions,
          ]),
        );
      });

      test('when properties are same they are equal', () {
        // NOTE: if signature changes, unequal test may require
        // need to change or new ones added.
        final other = PhysicalTherapy(
          givenDependent,
          givenCaregiver,
          givenTreatmentDescription,
          givenTreatmentDirections,
          givenRepetitions,
        );

        expect(physicalTherapy, equals(other));
      });

      test('when repetitions differ they are not equal', () {
        final otherRepetitions = PhysicalTherapyRepetitions(23);

        final other = PhysicalTherapy(
          givenDependent,
          givenCaregiver,
          givenTreatmentDescription,
          givenTreatmentDirections,
          otherRepetitions,
        );

        expect(physicalTherapy, isNot(other));
      });
    });

    group('toString', () {
      test('returns string', () {
        expect(
          physicalTherapy.toString(),
          equals(
            'PhysicalTherapy('
            '$givenDependent'
            ', $givenCaregiver'
            ', $givenTreatmentDescription'
            ', $givenTreatmentDirections'
            ', $givenRepetitions'
            ')',
          ),
        );
      });
    });
  });
}
