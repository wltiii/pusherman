import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/over_the_counter.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';

void main() {
  const givenDependentIdValue = 'abc123';
  const givenDependentNameValue = 'aUserName';
  const givenCaregiverIdValue = 'caregiver789';
  const givenCaregiverNameValue = 'aCaregiverName';
  const givenTherapyDescriptionValue = 'aOverTheCounterDescription';
  const givenTherapyDirectionsValue = 'aOverTheCounterDirections';

  final givenDependent = Dependent(
    UserId(givenDependentIdValue),
    UserName(givenDependentNameValue),
  );

  final givenCaregiver = Caregiver(
    UserId(givenCaregiverIdValue),
    UserName(givenCaregiverNameValue),
  );

  group('OverTheCounterDescription', () {
    test('OverTheCounterDescription constructs', () {
      final result = OverTheCounterDescription(
        givenTherapyDescriptionValue,
      );
      expect(result, isA<TreatmentDescription>());
      expect(result.value, equals(givenTherapyDescriptionValue));
    });
  });

  group('OverTheCounterDirections', () {
    test('OverTheCounterDirections constructs', () {
      final result = OverTheCounterDirections(givenTherapyDirectionsValue);
      expect(result, isA<TreatmentDirections>());
      expect(result.value, equals(givenTherapyDirectionsValue));
    });
  });

  group('physical therapy', () {
    final givenTreatmentDescription =
        OverTheCounterDescription(givenTherapyDescriptionValue);
    final givenTreatmentDirections =
        OverTheCounterDirections(givenTherapyDirectionsValue);

    final otcTreatment = OverTheCounter(
      givenDependent,
      givenCaregiver,
      givenTreatmentDescription,
      givenTreatmentDirections,
    );

    group('construction', () {
      test('instantiates', () {
        expect(otcTreatment, isA<Equatable>());
        expect(otcTreatment, isA<Treatment>());
        expect(otcTreatment.dependent, equals(givenDependent));
        expect(otcTreatment.caregiver, equals(givenCaregiver));
        expect(
          otcTreatment.description,
          equals(givenTherapyDescriptionValue),
        );
        expect(
          otcTreatment.directions,
          equals(givenTherapyDirectionsValue),
        );
      });
    });

    // Because this class extends Equatable, checking that equality
    // works should be irrelevant. We do so here anyway for it is
    // difficult to assure that all properties in a class are
    // represented.
    group('equality', () {
      // TODO(wltiii): is there a better way to verify all properties are included
      test('props contains list of all properties that determine equality', () {
        expect(
          otcTreatment.props,
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
        final other = OverTheCounter(
          givenDependent,
          givenCaregiver,
          givenTreatmentDescription,
          givenTreatmentDirections,
        );

        expect(otcTreatment, equals(other));
      });
    });

    group('toString', () {
      test('returns string', () {
        expect(
          otcTreatment.toString(),
          equals(
            'OverTheCounter('
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
