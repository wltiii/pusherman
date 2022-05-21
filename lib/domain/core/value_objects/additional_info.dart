import 'package:pusherman/domain/core/value_objects/non_empty_string.dart';

class AdditionalInfo extends NonEmptyString {
  AdditionalInfo(
    String value, {
    List<Function>? validators,
  }) : super(
          value,
          validators: validators ?? [],
        );
}