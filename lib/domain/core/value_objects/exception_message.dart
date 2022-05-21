import 'package:pusherman/domain/core/value_objects/non_empty_string.dart';

/// [ExceptionMessage] is a contain a human readable, and often user friendly,
/// of an exceptional condition. It is extended from [NonEmptyString], thus
/// must not be empty.
class ExceptionMessage extends NonEmptyString {
  ExceptionMessage(String value) : super(value);
}
