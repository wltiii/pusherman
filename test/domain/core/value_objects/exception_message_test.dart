import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/models/value_objects/exception_message.dart';

void main() {
  group('construction', () {
    test('constructs', () {
      const value = 'My what a pretty face you have!';
      final message = ExceptionMessage(value);
      expect(message, isA<ExceptionMessage>());
      expect(message.value, equals(value));
      expect(message.toString(), equals('ExceptionMessage($value)'));
    });
  });
}
