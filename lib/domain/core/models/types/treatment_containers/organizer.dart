import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/compartment.dart';
import 'package:pusherman/domain/core/models/value_objects/natural_number.dart';
import 'package:pusherman/domain/core/models/value_objects/non_empty_string.dart';

@JsonSerializable(explicitToJson: true)
class Organizer extends Equatable {
  const Organizer(
    this._name,
    this._frequency,
    this._compartment,
    this._numberOfCompartments,
  );

  final OrganizerName _name;
  // TODO(wltiii): the following really feels like two fields...
  // TODO(wltiii): not really frequency - each organizer would be for a given
  // TODO(wltiii): time of day, day of week, etc. so this gets complicated.
  // TODO(wltiii): E.g. organizer for first day of month? daily organizer? hourly
  // TODO(wltiii): organizer? something more enum like? If times, the organizer
  // TODO(wltiii): is named for the time? i.e. Morning? Noon? Mid-afternoon? 6p?
  // TODO(wltiii): therefore, time-of-day for notification and
  // TODO(wltiii): frequency (daily, etc.), or?
  // TODO(wltiii): and, what about duration? say something you take 7 days?
  final OrganizerFrequency _frequency;
  final Compartment _compartment;
  final NumberOfCompartments _numberOfCompartments;

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

  @override
  List<Object> get props => [
        _name,
        _frequency,
        _compartment,
        _numberOfCompartments,
      ];

  @override
  bool get stringify => true;
}

// TODO(wltiii): add logic such as TreatmentDescription for meaningful message
// TODO(wltiii): also remove tests of other types with no logic
class OrganizerName extends NonEmptyString {
  OrganizerName(String value) : super(value);
}

class OrganizerFrequency extends NonEmptyString {
  OrganizerFrequency(String value) : super(value);
}

class NumberOfCompartments extends NaturalNumber {
  NumberOfCompartments(int value) : super(value);
}