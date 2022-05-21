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

  final pillBoxSetModel = PillBoxSetModel(
    dependent: "Coda",
    caretakers: caretakers,
    pillBoxes: pillBoxes,
  );

  final pillBoxSetJson = fixtureAsString('coda_pill_box_set.json');

  final expectedPillBoxSetMap = {
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
    test('instantiates a PillBoxSetModel from named constructor', () async {
      expect(pillBoxSetModel.dependent, equals('Coda'));
      expect(pillBoxSetModel.caretakers, equals(caretakers));
      expect(pillBoxSetModel.pillBoxes, pillBoxes);
    });

    test('should be a subclass of PillBoxSet entity', () async {
      expect(pillBoxSetModel, isA<PillBoxSet>());
    });

    test("instantiates object from JSON", () async {
      // given
      final Map<String, dynamic> jsonMap = json.decode(pillBoxSetJson);
      // when
      final result = PillBoxSetModel.fromJson(jsonMap);
      // then
      expect(result, pillBoxSetModel);
    });
  });

  group("to JSON", () {
    test("instantiates JSON from object", () async {
      // when
      final result = pillBoxSetModel.toJson();
      // then
      expect(result, expectedPillBoxSetMap);
    });
  });
}
