import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/value_objects/natural_number.dart';

void main() {
  group('construction', () {
    test('constructs', () {
      const givenValue = 42;
      final result = NaturalNumber(givenValue);
      expect(result, isA<Equatable>());
      expect(result.value, equals(givenValue));
      expect(result.toString(), equals('NaturalNumber($givenValue)'));
    });
  });

  group('boundary tests', () {
    test('valid boundary edge value constructs', () {
      const givenValue = 1;
      final result = NaturalNumber(givenValue);
      expect(result, isA<NaturalNumber>());
    });
    test('valid boundary edge value throws', () {
      const givenValue = 0;

      expect(
        () => NaturalNumber(givenValue),
        throwsA(
          predicate(
            (e) =>
                e is NumberValueException &&
                e.message ==
                    'Invalid value.'
                        ' The number cannot be'
                        ' less that one.',
          ),
        ),
      );
    });
  });
}
