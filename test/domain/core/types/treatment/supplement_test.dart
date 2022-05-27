import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/supplement.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';
import 'package:pusherman/domain/core/models/value_objects/natural_number.dart';
import 'package:pusherman/domain/core/models/value_objects/whole_number.dart';

void main() {
  const givenDependentIdValue = 'abc123';
  const givenDependentNameValue = 'aUserName';
  const givenCaregiverIdValue = 'caregiver789';
  const givenCaregiverNameValue = 'aCaregiverName';
  const givenTherapyDescriptionValue = 'aSupplementDescription';
  const givenTherapyDirectionsValue = 'aSupplementDirections';
  const givenRefillQuantityValue = 42;
  const givenOnHandQuantityValue = 23;

  final givenDependent = Dependent(
    UserId(givenDependentIdValue),
    UserName(givenDependentNameValue),
  );

  final givenCaregiver = Caregiver(
    UserId(givenCaregiverIdValue),
    UserName(givenCaregiverNameValue),
  );

  group('Supplement value objects', () {
    group('SupplementDescription', () {
      test('SupplementDescription constructs', () {
        final result = SupplementDescription(givenTherapyDescriptionValue);
        expect(result, isA<TreatmentDescription>());
        expect(result.value, equals(givenTherapyDescriptionValue));
      });
    });

    group('SupplementDirections', () {
      test('SupplementDirections constructs', () {
        final result = SupplementDirections(givenTherapyDirectionsValue);
        expect(result, isA<TreatmentDirections>());
        expect(result.value, equals(givenTherapyDirectionsValue));
      });
    });

    group('SupplementRefillQuantity', () {
      test('SupplementRefillQuantity constructs', () {
        final result = SupplementRefillQuantity(givenRefillQuantityValue);
        expect(result, isA<NaturalNumber>());
        expect(result.value, equals(givenRefillQuantityValue));
      });
    });

    group('SupplementOnHandQuantity', () {
      test('SupplementOnHandQuantity constructs', () {
        final result = SupplementOnHandQuantity(givenOnHandQuantityValue);
        expect(result, isA<WholeNumber>());
        expect(result.value, equals(givenOnHandQuantityValue));
      });
    });
  });

  group('Supplement tests', () {
    final givenTreatmentDescription =
        SupplementDescription(givenTherapyDescriptionValue);
    final givenTreatmentDirections =
        SupplementDirections(givenTherapyDirectionsValue);
    final givenTreatmentRefillQuantity =
        SupplementRefillQuantity(givenRefillQuantityValue);
    final givenTreatmentOnHandQuantity =
        SupplementOnHandQuantity(givenOnHandQuantityValue);

    final supplement = Supplement(
      givenDependent,
      givenCaregiver,
      givenTreatmentDescription,
      givenTreatmentDirections,
      givenTreatmentRefillQuantity,
      givenTreatmentOnHandQuantity,
    );

    group('construction', () {
      test('instantiates', () {
        expect(supplement, isA<Equatable>());
        expect(supplement, isA<Treatment>());
        expect(supplement.dependent, equals(givenDependent));
        expect(supplement.caregiver, equals(givenCaregiver));
        expect(
          supplement.description,
          equals(givenTherapyDescriptionValue),
        );
        expect(
          supplement.directions,
          equals(givenTherapyDirectionsValue),
        );
        expect(
          supplement.refillQuantity,
          equals(givenRefillQuantityValue),
        );
        expect(
          supplement.onHandQuantity,
          equals(givenOnHandQuantityValue),
        );
      });
    });

    // Because this class extends Equatable, checking that equality
    // works should be irrelevant. We do so here anyway for it is
    // difficult to assure that all properties in a class are
    // represented.
    group('equality', () {
      test('props contains list of all properties that determine equality', () {
        expect(
          supplement.props,
          equals(<dynamic>[
            givenDependent,
            givenCaregiver,
            givenTreatmentDescription,
            givenTreatmentDirections,
            givenTreatmentRefillQuantity,
            givenTreatmentOnHandQuantity,
          ]),
        );
      });

      test('when properties are same they are equal', () {
        // NOTE: if signature changes, unequal test may require
        // need to change or new ones added.
        final other = Supplement(
          givenDependent,
          givenCaregiver,
          givenTreatmentDescription,
          givenTreatmentDirections,
          givenTreatmentRefillQuantity,
          givenTreatmentOnHandQuantity,
        );

        expect(supplement, equals(other));
      });

      test('when refill quantities differ they are not equal', () {
        final otherRefillQuantity =
            SupplementRefillQuantity(givenRefillQuantityValue + 23);

        final other = Supplement(
          givenDependent,
          givenCaregiver,
          givenTreatmentDescription,
          givenTreatmentDirections,
          otherRefillQuantity,
          givenTreatmentOnHandQuantity,
        );

        expect(Supplement, isNot(other));
      });

      test('when on-hand quantities differ they are not equal', () {
        final otherOnHandQuantity =
            SupplementOnHandQuantity(givenOnHandQuantityValue + 23);

        final other = Supplement(
          givenDependent,
          givenCaregiver,
          givenTreatmentDescription,
          givenTreatmentDirections,
          givenTreatmentRefillQuantity,
          otherOnHandQuantity,
        );

        expect(Supplement, isNot(other));
      });
    });

    group('toString', () {
      test('returns string', () {
        expect(
          supplement.toString(),
          equals(
            'Supplement('
            '$givenDependent'
            ', $givenCaregiver'
            ', $givenTreatmentDescription'
            ', $givenTreatmentDirections'
            ', $givenTreatmentRefillQuantity'
            ', $givenTreatmentOnHandQuantity'
            ')',
          ),
        );
      });
    });
  });
}
