import 'package:pusherman/domain/core/models/value_objects/additional_info.dart';
import 'package:pusherman/domain/core/models/value_objects/exception_message.dart';

/// [AppException] is the abstract class upon which all other
/// exceptions are derived. AppExceptions are serious errors
/// for which little can be done to mitigate. Callers should
/// handle exceptions in a safe manner to prevent further
/// catastrophe.
///
/// Each  [AppException] has a default [ExceptionMessage] and an optional
/// [AdditionalInfo] should the developer feels it necessary
/// to provide further information.
///
/// The [ExceptionMessage] and [AdditionalInfo] are concatenated to for
/// a [String] message that is exposed through a getter as
/// wells as toString method.
abstract class AppException implements Exception {
  AppException(ExceptionMessage message) {
    _message = message.value;
  }

  late String _message;

  String get message => _message;

  @override
  String toString() => message;
}

// Define specific exceptions below. And keep the classes sorted by name.

/// [NumberValueException]
class NumberValueException extends AppException {
  NumberValueException(ExceptionMessage message)
      : super(ExceptionMessage('Invalid value. ${message.value}'));
}

/// [ServerException] is thrown when a call to an external
/// service, database, etc. does not complete normally. Errors, faults, etc.,
/// that can be expected are NOT exceptions.
class ServerException extends AppException {
  ServerException(ExceptionMessage message)
      : super(ExceptionMessage('Server exception. ${message.value}'));
}

/// [StringInvalidException] is thrown when an invalid value is detected that
/// cannot be handled otherwise.
class StringInvalidException extends AppException {
  StringInvalidException() : super(ExceptionMessage('Invalid value.'));
}

/// [UnsupportedException] is thrown when the requested action is not
/// supported by the application.
class UnsupportedException extends AppException {
  UnsupportedException(ExceptionMessage message)
      : super(ExceptionMessage('Unsupported exception. ${message.value}'));
}

/// [ValueException] is thrown when an invalid value is detected that cannot
/// be handled otherwise.
class ValueException extends AppException {
  ValueException(ExceptionMessage message)
      : super(ExceptionMessage('Invalid value. ${message.value}'));
}
