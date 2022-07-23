import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';
import 'package:pusherman/domain/core/models/types/type_defs.dart';
import 'package:pusherman/domain/core/models/value_objects/exception_message.dart';

part 'compartment.freezed.dart';
part 'compartment.g.dart';

@JsonSerializable(explicitToJson: true)
@freezed
class Compartment with _$Compartment {
  const Compartment._();

  factory Compartment(
    List<Treatment> treatments,
  ) {
    // _treatments = validate(treatments);
    treatments = validate(treatments);
  }

  static Set<Treatment> validate(
    List<Treatment> treatments,
  ) {
    if (treatments.isEmpty) return treatments.toSet();

    final set = treatments.toSet();
    if (set.length != treatments.length) {
      throw ValueException(
        ExceptionMessage(
          'Treatment list contains duplicates.',
        ),
      );
    }

    if (!treatments.every(
      (Treatment e) =>
          e.dependent == treatments[0].dependent &&
          e.caregiver == treatments[0].caregiver,
    )) {
      throw ValueException(
        ExceptionMessage(
          'One or more treatments do not'
          ' have the same dependent or caregiver.',
        ),
      );
    }

    treatments.sort(
      (Treatment a, Treatment b) => a.description.compareTo(b.description),
    );

    return treatments.toSet();
  }

  // late final Set<Treatment> _treatments;

  // List<Treatment> get list => _treatments.toList();
  List<Treatment> get list => treatments.toList();

  String get dependentName =>
      list.isNotEmpty ? list[0].dependent.name : '';

  String get caregiverName =>
      list.isNotEmpty ? list[0].caregiver.name : '';

// @override
// List<Object> get props => [_treatments];

// @override
// bool get stringify => true;

  /// Connect the generated [_$CompartmentFromJson] function to the `fromJson`
  /// factory.
  factory Compartment.fromJson(Json json) =>
      _$CompartmentFromJson(json);

// factory TreatmentBox.fromJson(Map<String, dynamic> json) {
//   var somePills = json['pills'].map((pill) => Pill.fromJson(pill))
//       .toList()
//       .cast<Pill>();
//
//   var pillSet = TreatmentBox(
//     _name: json['name'],
//     _frequency: json['frequency'] ?? '',
//     _treatments: somePills,
//   );
//
//   return pillSet;
//
// }

// Map<String, dynamic> toJson() {
//   return {
//     "name": _name,
//   };
// }
}