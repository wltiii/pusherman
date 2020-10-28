import 'package:pusherman/core/presentation/converter/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
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
}