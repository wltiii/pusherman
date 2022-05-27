import 'package:equatable/equatable.dart';

/// A [MaybeEmptyString] represents a possibly zero length [String] after
/// trimming trailing spaces.
///
/// All string type value objects having these requirements should implement
/// this class.
abstract class MaybeEmptyString extends Equatable {
  MaybeEmptyString(
    String value, {
    List<Function>? validators,
  }) {
    _value = validate(value.trimRight(), validators ?? []);
  }

  static String validate(String value, List<Function> validators) {
    for (var i = 0; i < validators.length; i++) {
      final test = validators[i] as Function(String);
      test(value);
    }

    return value;
  }

  // Using both late and final modifiers rids the class of warning:
  // This class (or a class that this class inherits from) is marked as
  // '@immutable', but one or more of its instance fields aren't final
  late final String _value;

  String get value => _value;

  @override
  List get props => <String>[_value];

  @override
  bool get stringify => true;
}
