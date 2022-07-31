import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';
import 'package:pusherman/domain/core/models/value_objects/exception_message.dart';

// part 'compartment.g.dart';

// @JsonSerializable(explicitToJson: true)
// class Compartment extends Equatable {
class Compartment {
  Compartment(
    List<Treatment> treatments,
  ) : _treatments = validate(treatments);

// factory Compartment.fromJson(Map<String, dynamic> json) {
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

  // /// Connect the generated [_$CompartmentFromJson] function to the `fromJson`
  // /// factory.
  // factory Compartment.fromJson(Json json) => _$CompartmentFromJson(json);

  // /// Connect the generated [_$CompartmentToJson] function to the `toJson` method.
  // Map<String, dynamic> toJson() => _$CompartmentToJson(this);

  late final Set<Treatment> _treatments;

  // List<Treatment> get list => _treatments.toList();
  List<Treatment> get list => _treatments.toList();

  String get dependentName => list.isNotEmpty ? list[0].dependent.name : '';

  String get caregiverName => list.isNotEmpty ? list[0].caregiver.name : '';

  @override
  List<Object> get props => [_treatments];

  @override
  bool get stringify => true;

  /// Connect the generated [_$CompartmentFromJson] function to the `fromJson`
  /// factory.
// factory Compartment.fromJson(Json json) => _$CompartmentFromJson(json);

  // Json toJson() {
  //   return {
  //     "compartments": [
  //       {
  //         "runtimeType": "Prescription",
  //         "caregiver": "Bill",
  //         "dependent": "Coda",
  //         "description": "A Test Prescription",
  //         "directions": "Take frequently",
  //         "prescriptionRefillQuantity": 30,
  //         "prescriptionOnHandQuantity": 17
  //       }
  //     ]
  //   };
  // }

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
}
