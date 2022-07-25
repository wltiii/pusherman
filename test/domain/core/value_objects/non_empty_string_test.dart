import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/value_objects/maybe_empty_string.dart';
import 'package:pusherman/domain/core/models/value_objects/non_empty_string.dart';

class NonEmptyStringTester extends NonEmptyString {
  NonEmptyStringTester(String value) : super(value);
}

void main() {
  group('construction', () {
    test('constructs', () {
      const value = 'My what a pretty face you have!';
      final aString = NonEmptyStringTester(value);
      expect(aString, isA<MaybeEmptyString>());
      expect(aString, isA<NonEmptyString>());
      expect(aString, isA<Equatable>());
      expect(aString.value, equals(value));
    });

    test('throws when string has zero length', () {
      expect(
        () => NonEmptyStringTester(''),
        throwsA(
          predicate(
            (e) => e is StringInvalidException && e.message == 'Invalid value.',
          ),
        ),
      );
    });

    test('throws when string of spaces only', () {
      expect(
        () => NonEmptyStringTester(' '),
        throwsA(
          predicate(
            (e) => e is StringInvalidException && e.message == 'Invalid value.',
          ),
        ),
      );
    });
  });
}