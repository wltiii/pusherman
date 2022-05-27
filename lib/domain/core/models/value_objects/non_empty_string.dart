import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/value_objects/maybe_empty_string.dart';

/// A [NonEmptyString] represents a non-zero length [String] after trimming
/// trailing spaces.
///
/// All string type value objects having these requirements should implement
/// this class.
///
/// The class takes two arguments: [String] value and an optional [List] of
/// validators functions.
///
/// Validator functions test the value and should throw an appropriate exception
/// when value does not conform to expectations. The list of validators is
/// appended with a defualt validator that throws a [StringInvalidException]
/// when attempting to construct with a zero length String or a String
/// containing only spaces. If this exception type or message be deemed
/// inappropriate, implementors should include a validator should be included to
/// circumvent the need for the default test. It's sole purpose is to guarantee
/// that an object of NonEmptyString cannot be created with an empty value, in
/// other words: MAKING ILLEGAL STATE UNREPRESENTABLE.
///
/// Writing implementations of this class that could be extended themselves
/// should be cqreful such that they implement a call to super with validations
/// that are mandatory for extended class append those validations to the list
/// of validators with which the extended class was called. See the call
/// to super in [NonEmptyString] for an example of implementing a chainable
/// stack of validators.
abstract class NonEmptyString extends MaybeEmptyString {
  NonEmptyString(
    String value, {
    List<Function>? validators,
  }) : super(
          value,
          validators: validators ?? []
            ..addAll(_defaultValidators),
        );
}

/// [_defaultValidators] are appended to the list of validators, thus only
/// called if the list of validators has not thrown a validation exception.
List<Function> _defaultValidators = [
  (String value) =>
      {if (value.trimRight().isEmpty) throw StringInvalidException()},
];
