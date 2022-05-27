import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';
import 'package:pusherman/domain/core/models/value_objects/non_empty_string.dart';

class AbstractTreatmentTester extends Treatment {
  AbstractTreatmentTester(
    Dependent dependent,
    Caregiver? caregiver,
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
  const givenDependentIdValue = 'dependent123';
  const givenDependentNameValue = 'aDependentName';
  const givenCaregiverIdValue = 'caregiver789';
  const givenCaregiverNameValue = 'aCaregiverName';
  const givenTherapyDescriptionValue = 'aTreatment';
  const givenTherapyDirectionsValue = 'aSupplementDirections';

  final givenDependent = Dependent(
    UserId(givenDependentIdValue),
    UserName(givenDependentNameValue),
  );

  final givenCaregiver = Caregiver(
    UserId(givenCaregiverIdValue),
    UserName(givenCaregiverNameValue),
  );

  group('TreatmentDescription', () {
    test('TreatmentDescription constructs', () {
      final result = TreatmentDescription(givenTherapyDescriptionValue);
      expect(result, isA<NonEmptyString>());
      expect(result, isA<Equatable>());
      expect(result.value, equals(givenTherapyDescriptionValue));
    });

    test('malformed TreatmentDescription throws', () {
      expect(
        () => TreatmentDescription(''),
        throwsA(
          predicate(
            (e) =>
                e is ValueException &&
                e.message == 'Invalid value. Description must not be empty.',
          ),
        ),
      );
    });
  });

  group('TreatmentDirections', () {
    test('TreatmentDirections constructs', () {
      final result = TreatmentDirections(givenTherapyDirectionsValue);
      expect(result, isA<NonEmptyString>());
      expect(result, isA<Equatable>());
      expect(result.value, equals(givenTherapyDirectionsValue));
    });

    test('malformed TreatmentDirections throws', () {
      expect(
        () => TreatmentDirections(''),
        throwsA(
          predicate(
            (e) =>
                e is ValueException &&
                e.message == 'Invalid value. Directions must not be empty.',
          ),
        ),
      );
    });
  });

  group('abstract Treatment', () {
    final givenTreatmentDescription =
        TreatmentDescription(givenTherapyDescriptionValue);
    final givenTreatmentDirections =
        TreatmentDirections(givenTherapyDirectionsValue);

    final treatment = AbstractTreatmentTester(
      givenDependent,
      givenCaregiver,
      givenTreatmentDescription,
      givenTreatmentDirections,
    );

    group('construction', () {
      test('instantiates with Caregiver', () {
        expect(treatment, isA<Equatable>());
        expect(treatment.dependent, equals(givenDependent));
        expect(treatment.caregiver, equals(givenCaregiver));
        expect(
          treatment.description,
          equals(givenTherapyDescriptionValue),
        );
        expect(
          treatment.directions,
          equals(givenTherapyDirectionsValue),
        );
        expect(treatment.caregiverIsDependent, isFalse);
      });
      test('instantiates without Caregiver', () {
        final treatment = AbstractTreatmentTester(
          givenDependent,
          null,
          givenTreatmentDescription,
          givenTreatmentDirections,
        );

        expect(
          treatment.caregiver,
          equals(
            Caregiver(
              UserId(givenDependent.id),
              UserName(givenDependent.name),
            ),
          ),
        );
        expect(treatment.caregiverIsDependent, isTrue);
      });
    });

    // Because this class extends Equatable, checking that equality
    // works should be irrelevant. We do so here anyway for it is
    // difficult to assure that all properties in a class are
    // represented.
    group('equality', () {
      test('props contains list of all properties that determine equality', () {
        expect(
          treatment.props,
          equals(<dynamic>[
            givenDependent,
            givenCaregiver,
            givenTreatmentDescription,
            givenTreatmentDirections,
          ]),
        );
      });

      test('when properties are same they are equal', () {
        // NOTE: if signature changes, unequal test may require
        // need to change or new ones added.
        final other = AbstractTreatmentTester(
          givenDependent,
          givenCaregiver,
          givenTreatmentDescription,
          givenTreatmentDirections,
        );

        expect(treatment, equals(other));
      });

      test('when dependent ids differ they are not equal', () {
        final otherDependent = Dependent(
          UserId('otherDependentId'),
          UserName(givenDependentNameValue),
        );

        final other = AbstractTreatmentTester(
          otherDependent,
          givenCaregiver,
          givenTreatmentDescription,
          givenTreatmentDirections,
        );

        expect(treatment, isNot(other));
      });

      test('when dependent names differ they are not equal', () {
        final otherDependent = Dependent(
          UserId(givenDependentIdValue),
          UserName('otherDependentName'),
        );

        final other = AbstractTreatmentTester(
          otherDependent,
          givenCaregiver,
          givenTreatmentDescription,
          givenTreatmentDirections,
        );

        expect(treatment, isNot(other));
      });

      test('when caregiver ids differ they are not equal', () {
        final otherCaregiver = Caregiver(
          UserId('otherCaregiverId'),
          UserName(givenCaregiverNameValue),
        );

        final other = AbstractTreatmentTester(
          givenDependent,
          otherCaregiver,
          givenTreatmentDescription,
          givenTreatmentDirections,
        );

        expect(treatment, isNot(other));
      });

      test('when caregiver names differ they are not equal', () {
        final otherCaregiver = Caregiver(
          UserId(givenCaregiverIdValue),
          UserName('otherCaregiverName'),
        );

        final other = AbstractTreatmentTester(
          givenDependent,
          otherCaregiver,
          givenTreatmentDescription,
          givenTreatmentDirections,
        );

        expect(treatment, isNot(other));
      });

      test('when treatmentDescriptions differ they are not equal', () {
        final otherTreatmentDescription = TreatmentDescription(
          'otherTreatmentDescription',
        );

        final other = AbstractTreatmentTester(
          givenDependent,
          givenCaregiver,
          otherTreatmentDescription,
          givenTreatmentDirections,
        );

        expect(treatment, isNot(other));
      });

      test('when productNames differ they are not equal', () {
        final otherTreatmentDirections = TreatmentDirections(
          'otherTreatmentDirections',
        );
        final other = AbstractTreatmentTester(
          givenDependent,
          givenCaregiver,
          givenTreatmentDescription,
          otherTreatmentDirections,
        );

        expect(treatment, isNot(other));
      });
    });

    group('toString', () {
      test('returns string', () {
        expect(
          treatment.toString(),
          equals(
            'AbstractTreatmentTester('
            '$givenDependent'
            ', $givenCaregiver'
            ', $givenTreatmentDescription'
            ', $givenTreatmentDirections'
            ')',
          ),
        );
      });
    });
  });
}
