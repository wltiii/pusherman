import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pusherman/domain/core/models/model.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/compartment.dart';

import '../../type_defs.dart';
import '../organizer_types/types.dart' show NumberOfCompartments, OrganizerFrequency, OrganizerName;

part '../organizer.freezed.dart';
part '../organizer.g.dart';

@JsonSerializable(explicitToJson: true)
@freezed
class Organizer with _$Organizer implements Model {
  const Organizer._();

  const factory Organizer({
    required OrganizerName name,
    required OrganizerFrequency frequency,
    required Compartment compartment,
    required NumberOfCompartments numberOfCompartments,
  }) = _Organizer;

  factory Organizer.fromJson(Json json) => _$OrganizerFromJson(json);

  final OrganizerName name;

  // TODO(wltiii): the following really feels like two fields...
  // TODO(wltiii): not really frequency - each organizer would be for a given
  // TODO(wltiii): time of day, day of week, etc. so this gets complicated.
  // TODO(wltiii): E.g. organizer for first day of month? daily organizer? hourly
  // TODO(wltiii): organizer? something more enum like? If times, the organizer
  // TODO(wltiii): is named for the time? i.e. Morning? Noon? Mid-afternoon? 6p?
  // TODO(wltiii): therefore, time-of-day for notification and
  // TODO(wltiii): frequency (daily, etc.), or?
  // TODO(wltiii): and, what about duration? say something you take 7 days?
  final OrganizerFrequency frequency;
  final Compartment compartment;
  final NumberOfCompartments numberOfCompartments;

  String get dependentName => compartment.dependentName;

  String get caregiverName => compartment.caregiverName;

  String get organizerName => name.value;

  String get organizerFrequency => frequency.value;

  int get compartments => numberOfCompartments.value;
}
