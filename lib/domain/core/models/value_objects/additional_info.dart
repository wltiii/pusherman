import 'package:unrepresentable_state/unrepresentable_state.dart';

class AdditionalInfo extends NonEmptyString {
  AdditionalInfo(
    String value, {
    List<Function>? validators,
  }) : super(
          value,
          validators: validators ?? [],
        );
}
