import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/prescription.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';
import 'package:pusherman/domain/core/models/value_objects/natural_number.dart';
import 'package:pusherman/domain/core/models/value_objects/whole_number.dart';

void main() {
  const givenDependentIdValue = 'abc123';
  const givenDependentNameValue = 'aUserName';
  const givenCaregiverIdValue = 'caregiver789';
  const givenCaregiverNameValue = 'aCaregiverName';
  const givenTherapyDescriptionValue = 'aPrescriptionDescription';
  const givenTherapyDirectionsValue = 'aPrescriptionDirections';
  const givenRefillQuantityValue = 42;
  const givenOnHandQuantityValue = 23;

  // TODO consider defining givenDependent as late final... then initialize in
  // TODo setup block. This applies to other tests as well.

  final givenDependent = Dependent(
    UserId(givenDependentIdValue),
    DependentName(givenDependentNameValue),
  );

  final givenCaregiver = CareGiver(
    UserId(givenCaregiverIdValue),
    DependentName(givenCaregiverNameValue),
  );

  group('Prescription value objects', () {
    group('PrescriptionDescription', () {
      test('PrescriptionDescription constructs', () {
        final result = PrescriptionDescription(givenTherapyDescriptionValue);
        expect(result, isA<TreatmentDescription>());
        expect(result.value, equals(givenTherapyDescriptionValue));
      });
    });

    group('PrescriptionDirections', () {
      test('PrescriptionDirections constructs', () {
        final result = PrescriptionDirections(givenTherapyDirectionsValue);
        expect(result, isA<TreatmentDirections>());
        expect(result.value, equals(givenTherapyDirectionsValue));
      });
    });

    group('PrescriptionRefillQuantity', () {
      test('PrescriptionRefillQuantity constructs', () {
        final result = PrescriptionRefillQuantity(givenRefillQuantityValue);
        expect(result, isA<NaturalNumber>());
        expect(result.value, equals(givenRefillQuantityValue));
      });
    });

    group('PrescriptionOnHandQuantity', () {
      test('PrescriptionOnHandQuantity constructs', () {
        final result = PrescriptionOnHandQuantity(givenOnHandQuantityValue);
        expect(result, isA<WholeNumber>());
        expect(result.value, equals(givenOnHandQuantityValue));
      });
    });
  });

  group('Prescription tests', () {
    // const givenTherapyDescriptionValue = 'aPrescriptionDescription';
    // const givenTherapyDirectionsValue = 'aPrescriptionDirections';
    // const givenRefillQuantityValue = 42;
    // const givenOnHandQuantityValue = 23;
    final givenTreatmentDescription = PrescriptionDescription(givenTherapyDescriptionValue);
    final givenTreatmentDirections = PrescriptionDirections(givenTherapyDirectionsValue);
    final givenTreatmentRefillQuantity = PrescriptionRefillQuantity(givenRefillQuantityValue);
    final givenTreatmentOnHandQuantity = PrescriptionOnHandQuantity(givenOnHandQuantityValue);

    final prescription = Prescription(
      givenDependent,
      givenCaregiver,
      givenTreatmentDescription,
      givenTreatmentDirections,
      givenTreatmentRefillQuantity,
      givenTreatmentOnHandQuantity,
    );

    group('construction', () {
      test('instantiates', () {
        expect(prescription, isA<Equatable>());
        expect(prescription, isA<Treatment>());
        expect(prescription.dependent, equals(givenDependent));
        expect(prescription.caregiver, equals(givenCaregiver));
        expect(
          prescription.description,
          equals(givenTherapyDescriptionValue),
        );
        expect(
          prescription.directions,
          equals(givenTherapyDirectionsValue),
        );
        expect(
          prescription.refillQuantity,
          equals(givenRefillQuantityValue),
        );
        expect(
          prescription.onHandQuantity,
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
          prescription.props,
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
        final other = Prescription(
          givenDependent,
          givenCaregiver,
          givenTreatmentDescription,
          givenTreatmentDirections,
          givenTreatmentRefillQuantity,
          givenTreatmentOnHandQuantity,
        );

        expect(prescription, equals(other));
      });

      test('when refill quantities differ they are not equal', () {
        final otherRefillQuantity = PrescriptionRefillQuantity(givenRefillQuantityValue + 23);

        final other = Prescription(
          givenDependent,
          givenCaregiver,
          givenTreatmentDescription,
          givenTreatmentDirections,
          otherRefillQuantity,
          givenTreatmentOnHandQuantity,
        );

        expect(Prescription, isNot(other));
      });

      test('when on-hand quantities differ they are not equal', () {
        final otherOnHandQuantity = PrescriptionOnHandQuantity(givenOnHandQuantityValue + 23);

        final other = Prescription(
          givenDependent,
          givenCaregiver,
          givenTreatmentDescription,
          givenTreatmentDirections,
          givenTreatmentRefillQuantity,
          otherOnHandQuantity,
        );

        expect(Prescription, isNot(other));
      });
    });

    group('toString', () {
      test('returns string', () {
        expect(
          prescription.toString(),
          equals(
            'Prescription('
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
