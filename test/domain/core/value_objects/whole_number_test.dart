import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/value_objects/whole_number.dart';

void main() {
  group('construction', () {
    test('constructs', () {
      const givenValue = 42;
      final result = WholeNumber(givenValue);
      expect(result, isA<Equatable>());
      expect(result.value, equals(givenValue));
      expect(result.toString(), equals('WholeNumber($givenValue)'));
    });
  });

  group('boundary tests', () {
    test('valid boundary edge value constructs', () {
      const givenValue = 1;
      final result = WholeNumber(givenValue);
      expect(result, isA<WholeNumber>());
    });
    test('valid boundary edge value throws', () {
      const givenValue = 0;

      expect(
        () => WholeNumber(givenValue),
        throwsA(
          predicate(
            (e) =>
                e is NumberValueException &&
                e.message ==
                    'Invalid value.'
                        ' The number cannot be'
                        ' less that zero.',
          ),
        ),
      );
    });
  });
}
