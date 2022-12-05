// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:pusherman/domain/core/models/types/auth/user.dart';
// import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';
//
// import '../type_defs.dart';
//
// part 'over_the_counter.freezed.dart';
// part 'over_the_counter.g.dart';
//
// /// A [OverTheCounter] is a medication used to treat an ailment. It does not
// /// require a prescription.
// ///
// /// It can take many forms: pills, topicals, liquids, etc.
// ///
// /// See also:
// /// [Treatment], [User], [OverTheCounterDescription] and
// /// [OverTheCounterDirections].
// ///
// @JsonSerializable(explicitToJson: true)
// @freezed
// class OverTheCounter extends Treatment with _$OverTheCounter {
//   const OverTheCounter._();
//
//   const factory OverTheCounter(
//     Dependent dependent,
//     CareGiver? caregiver,
//     OverTheCounterDescription description,
//     OverTheCounterDirections directions,
//   ) : super(
//           dependent,
//           caregiver,
//           description,
//           directions,
//         ) = _OverTheCounter;
//
//   /// Connect the generated [_$OverTheCounterFromJson] function to the `fromJson`
//   /// factory.
//   factory OverTheCounter.fromJson(Json json) =>
//       _$OverTheCounterFromJson(json);
//
// }
//
// class OverTheCounterDescription extends TreatmentDescription {
//   OverTheCounterDescription(String value) : super(value);
// }
//
// class OverTheCounterDirections extends TreatmentDirections {
//   OverTheCounterDirections(String value) : super(value);
// }
