import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/models/value_objects/maybe_empty_string.dart';

class AbstractMaybeEmptyStringTester extends MaybeEmptyString {
  AbstractMaybeEmptyStringTester(String value) : super(value);
}

void main() {
  group('construction', () {
    test('with populated string', () {
      const value = 'My what a pretty face you have!';
      final aString = AbstractMaybeEmptyStringTester(value);
      expect(aString, isA<MaybeEmptyString>());
      expect(aString, isA<Equatable>());
      expect(aString.value, equals(value));
    });

    test('with zero length string', () {
      const givenZeroLengthString = '';
      final aString = AbstractMaybeEmptyStringTester(givenZeroLengthString);
      expect(aString, isA<MaybeEmptyString>());
      expect(aString, isA<Equatable>());
      expect(aString.value, equals(givenZeroLengthString));
    });

    test('with string of spaces only', () {
      const value = '      ';
      const expectedZeroLengthString = '';
      final aString = AbstractMaybeEmptyStringTester(value);
      expect(aString, isA<MaybeEmptyString>());
      expect(aString, isA<Equatable>());
      expect(aString.value, equals(expectedZeroLengthString));
    });
  });

  // Because this class extends Equatable, checking that equality
  // works should be irrelevant. We do so here anyway for it is
  // difficult to assure that all properties in a class are
  // represented.
  group('equality', () {
    test('equal strings returns true', () {
      const value1 = 'My what a pretty face you have!';
      const value2 = 'My what a pretty face you have!';
      final string1 = AbstractMaybeEmptyStringTester(value1);
      final string2 = AbstractMaybeEmptyStringTester(value2);

      expect(string1.value, equals(value1));
      expect(string1.value == value1, isTrue);
      expect(string2.value, equals(value2));
      expect(string2.value == value2, isTrue);
      expect(string1, equals(string2));
      expect(string1 == string2, isTrue);
    });

    test('unequal strings is false', () {
      const value1 = 'My what a pretty face you have!';
      const value2 = 'Why thank you.';
      final string1 = AbstractMaybeEmptyStringTester(value1);
      final string2 = AbstractMaybeEmptyStringTester(value2);
      expect(string1, isNot(string2));
    });
  });

  group('toString', () {
    test('returns string', () {
      const value = 'My what a pretty face you have!';
      final aString = AbstractMaybeEmptyStringTester(value);
      expect(
        aString.toString(),
        equals('AbstractMaybeEmptyStringTester($value)'),
      );
    });
  });
}
