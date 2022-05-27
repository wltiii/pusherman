import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/value_objects/exception_message.dart';
import 'package:pusherman/domain/core/models/value_objects/non_empty_string.dart';

/// [Password] is a container for a validated password.
///
/// It appears Firebase authentication only validates that passwords are a
/// minimum of six characters. Therefore, we have added a few additional rules.
///
class Password extends NonEmptyString {
  Password(
    String value, {
    List<Function>? validators,
  }) : super(
          value,
          validators: validators ?? []
            ..addAll(_defaultValidators),
        );
}

final List<Function> _defaultValidators = [
  (String value) =>
      {if (value.trimRight().length < 6) throw _passwordLengthException},
  (String value) =>
      {if (!value.contains(RegExp('[A-Z]'))) throw _passwordFormatException},
  (String value) =>
      {if (!value.contains(RegExp('[a-z]'))) throw _passwordFormatException},
  (String value) =>
      {if (!value.contains(RegExp('[0-9]'))) throw _passwordFormatException},
  (String value) => {
        if (!value.contains(RegExp(r'[!$>_}.<"|+):/*+&^]')))
          throw _passwordFormatException,
      },
];

final _passwordLengthException = ValueException(
  ExceptionMessage('Password must be a minimum of six characters.'),
);

final _passwordFormatException = ValueException(
  ExceptionMessage(
    'Password is invalid. '
    'It must at lease one upper case letter, '
    'one lower case letter and '
    r'one of !$>_}.<"|+):/*+&^.',
  ),
);
