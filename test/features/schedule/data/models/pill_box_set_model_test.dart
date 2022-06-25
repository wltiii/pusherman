import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_model.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:pusherman/features/schedule/data/models/pill_model.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box.dart';

import '../../../../fixtures/fixture_reader.dart' show fixtureAsString;

void main() {
  final nexGard = PillModel(name: "NexGard");
  final heartgard = PillModel(name: "Heartgard");

  final pillBox = PillBoxModel(
      name: "On 15th", frequency: "Monthly", pills: [nexGard, heartgard]);
  final caretakers = ["Bill", "Pooh"];
  final pillBoxes = [pillBox];

  final Organizer = Organizer(
    dependent: "Coda",
    caretakers: caretakers,
    pillBoxes: pillBoxes,
  );

  final OrganizerJson = fixtureAsString('coda_organizer.json');

  final expectedOrganizerMap = {
    "dependent": "Coda",
    "caretakers": ["Bill", "Pooh"],
    "pillBoxes": [
      {
        "name": "On 15th",
        "frequency": "Monthly",
        "pills": [
          {
            "name": "NexGard",
          },
          {
            "name": "Heartgard",
          }
        ]
      }
    ]
  };

  group("construction", () {
    test('instantiates a Organizer from named constructor', () async {
      expect(Organizer.dependent, equals('Coda'));
      expect(Organizer.caretakers, equals(caretakers));
      expect(Organizer.pillBoxes, pillBoxes);
    });

    test('should be a subclass of Organizer entity', () async {
      expect(Organizer, isA<Organizer>());
    });

    test("instantiates object from JSON", () async {
      // given
      final Map<String, dynamic> jsonMap = json.decode(OrganizerJson);
      // when
      final result = Organizer.fromJson(jsonMap);
      // then
      expect(result, Organizer);
    });
  });

  group("to JSON", () {
    test("instantiates JSON from object", () async {
      // when
      final result = Organizer.toJson();
      // then
      expect(result, expectedOrganizerMap);
    });
  });
}