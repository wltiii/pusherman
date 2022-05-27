import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/value_objects/exception_message.dart';

class AppExceptionTester extends AppException {
  AppExceptionTester(ExceptionMessage message)
      : super(ExceptionMessage('AppException exception. ${message.value}'));
}

void main() {
  final customMessage = ExceptionMessage('Great googly moogly!');

  test('AppException', () {
    final e = AppExceptionTester(customMessage);

    expect(e, isA<AppExceptionTester>());
    expect(e, isA<AppException>());
    expect(e, isA<Exception>());
    expect(e.message, equals('AppException exception. ${customMessage.value}'));
    expect(
      e.toString(),
      equals('AppException exception. ${customMessage.value}'),
    );
    expect(e.toString(), equals(e.message));
  });

  test('exception type has correct message', () {
    expect(
      NumberValueException(customMessage).message,
      equals(
        'Invalid value. '
        '${customMessage.value}',
      ),
    );

    expect(
      ServerException(customMessage).message,
      equals(
        'Server exception. '
        '${customMessage.value}',
      ),
    );

    expect(
      StringInvalidException().message,
      equals(
        'Invalid value.',
      ),
    );

    expect(
      UnsupportedException(customMessage).message,
      equals(
        'Unsupported exception. '
        '${customMessage.value}',
      ),
    );

    expect(
      ValueException(customMessage).message,
      equals(
        'Invalid value. '
        '${customMessage.value}',
      ),
    );
  });
}
