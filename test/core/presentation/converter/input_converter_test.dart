import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pusherman/core/presentation/converter/input_converter.dart';

void main() {
  InputConverter inputConverter = InputConverter();

  group('construction', () {
    test('factory', () {
      final instance = InputConverter();
      expect(instance, isNot(null));
      expect(instance, isA<InputConverter>());
    });
  });


  group('to unsigned integer', () {
    test('converts a string representing an unsigned integer to an integer', () async {
      // given
      final input = '42';

      // when
      final result = inputConverter.toUnsignedInteger(input);

      // then
      expect(result, Right(42));
    });

    test('returns Failure when attempting to convert non-numeric value', () async {
      // given
      final input = 'abc';

      // when
      final result = inputConverter.toUnsignedInteger(input);

      // then
      expect(result, Left(InvalidInputFailure()));
    });

    test('returns Failure when attempting to convert a signed numeric string', () async {
      // given
      final input = '-1';

      // when
      final result = inputConverter.toUnsignedInteger(input);

      // then
      expect(result, Left(InvalidInputFailure()));
    });
  });

  group('to word string', () {
    test('converts a non-zero length string to valid word string', () async {
      // given
      final input = 'bill';

      // when
      final result = inputConverter.toWordString(input);

      // then
      expect(result, Right("bill"));
    });

    test('returns trimmed string having leading and trailing spaces', () async {
      // given
      final input = ' bill ';

      // when
      final result = inputConverter.toWordString(input);

      // then
      expect(result, Right("bill"));
    });

    test('returns string having embedded spaces', () async {
      // given
      final input = 'bill is here';

      // when
      final result = inputConverter.toWordString(input);

      // then
      expect(result, Right("bill is here"));
    });

    test('returns string having numeric characters', () async {
      // given
      final input = '123';

      // when
      final result = inputConverter.toWordString(input);

      // then
      expect(result, Right("123"));
    });

    test('returns string having special characters', () async {
      // given
      final input = '!';

      // when
      final result = inputConverter.toWordString(input);

      // then
      expect(result, Right("!"));
    });

    test('returns Failure when attempting to convert null', () async {
      // given
      final input = null;

      // when
      final result = inputConverter.toWordString(input);

      // then
      expect(result, Left(InvalidInputFailure()));
    });

    test('returns Failure when attempting to convert an empty string', () async {
      // given
      final input = '';

      // when
      final result = inputConverter.toWordString(input);

      // then
      expect(result, Left(InvalidInputFailure()));
    });

    test('returns Failure when attempting to convert a string of only spaces', () async {
      // given
      final input = ' ';

      // when
      final result = inputConverter.toWordString(input);

      // then
      expect(result, Left(InvalidInputFailure()));
    });
  });
}