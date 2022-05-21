import 'package:equatable/equatable.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/value_objects/exception_message.dart';

/// A [WholeNumber] represents an integer that is equal to or greater
/// than zero.
///
/// The integer used to construct is validated
///
/// The class takes one [int] argument value.
///
/// Validator functions test the value and throw a [NumberValueException]
/// when attempting to construct with a value less than zero.
///
/// The sole purpose of this class is to guarantee
/// that an object of WholeNumber is a number defined by the set [0, 1, 2, ...]
/// in other words: MAKING ILLEGAL STATE UNREPRESENTABLE.
///
/// **See also:**
/// * [num] the super class for [int].
/// * [Numbers](https://dart.dev/guides/language/numbers) in
/// [A tour of the Dart language](https://dart.dev/guides/language/language-tour).
///
class WholeNumber extends Equatable {
  WholeNumber(
    int value,
  ) {
    if (value < 1) {
      throw NumberValueException(
        ExceptionMessage(
          'The number cannot be'
          ' less that zero.',
        ),
      );
    }

    _value = value;
  }

  // Using both late and final modifiers rids the class of warning:
  // This class (or a class that this class inherits from) is marked as
  // '@immutable', but one or more of its instance fields aren't final
  late final int _value;

  int get value => _value;

  @override
  List<Object?> get props => [_value];

  @override
  bool get stringify => true;
}
