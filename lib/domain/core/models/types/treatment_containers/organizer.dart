import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pusherman/domain/core/models/model.dart';
import 'package:pusherman/domain/core/models/value_objects/natural_number.dart';
import 'package:pusherman/domain/core/models/value_objects/non_empty_string.dart';

import 'compartment.dart';

part 'organizer.g.dart';

@JsonSerializable(explicitToJson: true)
class Organizer extends Equatable implements Model {
  Organizer(
    OrganizerName name,
    OrganizerFrequency frequency,
    Compartment compartment,
    NumberOfCompartments numberOfCompartments,
  ) {
    _name = name;
    _frequency = frequency;
    _compartment = compartment;
    _numberOfCompartments = numberOfCompartments;
  }

  late final OrganizerName _name;
  // TODO(wltiii): the following really feels like two fields...
  // TODO(wltiii): not really frequency - each organizer would be for a given
  // TODO(wltiii): time of day, day of week, etc. so this gets complicated.
  // TODO(wltiii): E.g. organizer for first day of month? daily organizer? hourly
  // TODO(wltiii): organizer? something more enum like? If times, the organizer
  // TODO(wltiii): is named for the time? i.e. Morning? Noon? Mid-afternoon? 6p?
  // TODO(wltiii): therefore, time-of-day for notification and
  // TODO(wltiii): frequency (daily, etc.), or?
  // TODO(wltiii): and, what about duration? say something you take 7 days?
  late final OrganizerFrequency _frequency;
  late final Compartment _compartment;
  late final NumberOfCompartments _numberOfCompartments;

  String get dependentName => _compartment.dependentName;

  String get caregiverName => _compartment.caregiverName;

  String get name => _name.value;

  String get frequency => _frequency.value;

  int get numberOfCompartments => _numberOfCompartments.value;

  // factory TreatmentOrganizer.fromJson(Map<String, dynamic> json) {
//   return TreatmentOrganizer(
  //       json['dependent'] ?? '',
  //       json['sets']
  //           .map((set) => TreatmentBox.fromJson(set))
  //           .toList()
  //           .cast<TreatmentBox>());
  // }

  /// Connect the generated [_$OrganizerFromJson] function to the `fromJson`
  /// factory.
  factory Organizer.fromJson(Map<String, dynamic> json) =>
      _$OrganizerFromJson(json);

  /// Connect the generated [_$OrganizerToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrganizerToJson(this);

  //TODO(wltiii): get props seems to beg to be generated
  @override
  List<Object> get props => [
        _name,
        _frequency,
        _compartment,
        _numberOfCompartments,
      ];

  //TODO(wltiii): most definitely this should be generated
  @override
  bool get stringify => true;
}

// TODO(wltiii): add logic such as TreatmentDescription for meaningful message
// TODO(wltiii): also remove tests of other types with no logic
@JsonSerializable(explicitToJson: true)
class OrganizerName extends NonEmptyString {
  OrganizerName(String value) : super(value);
}

class OrganizerFrequency extends NonEmptyString {
  OrganizerFrequency(String value) : super(value);
}

class NumberOfCompartments extends NaturalNumber {
  NumberOfCompartments(int value) : super(value);
}