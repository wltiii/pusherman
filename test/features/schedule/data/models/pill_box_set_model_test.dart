import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_model.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:pusherman/features/schedule/data/models/pill_model.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';

import '../../../../fixtures/fixture_reader.dart' show fixtureAsString;

void main() {
  final NexGard = PillModel(name: "NexGard");
  final Heartgard = PillModel(name: "Heartgard");

  final pillBox = PillBoxModel(name: "On 15th", frequency: "Monthly", pills: [NexGard, Heartgard]);

  final pillBoxes = [pillBox];

  final pillBoxSetModel = PillBoxSetModel(
    dependent: "Coda",
    pillBoxes: pillBoxes,
  );

  final pillBoxSetJson = fixtureAsString('coda_pill_box_set.json');

  final expectedPillBoxSetMap = {
    "dependent": "Coda",
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
