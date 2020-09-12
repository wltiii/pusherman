import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_model.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:pusherman/features/schedule/data/models/pill_model.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';

import '../../../../fixtures/fixture_reader.dart' show fixtureAsString;

void main() {
  final vitaminC = PillModel(name: "C");
  final evoo = PillModel(name: "Extra Virgin Olive Oil");
  final cinsulin = PillModel(name: "Cinsulin - Cinnamon");
  final coQ10 = PillModel(name: "Ubiquinol - CoQ10");

  final morningPills = PillBoxModel(name: 'Morning', frequency: "Daily", pills: [vitaminC, evoo]);
  final eveningPills = PillBoxModel(name: 'Bedtime', frequency: "Daily", pills: [cinsulin, coQ10]);

  final pillBoxes = [morningPills, eveningPills];

  final pillBoxSetModel = PillBoxSetModel(
    caretaker: "Bill",
    dependent: "Coda",
    pillBoxes: pillBoxes,
  );

  final pillBoxSetJson = fixtureAsString('pill_box_set.json');

  final pillBoxSetMap = {
    "caretaker": "Bill",
    "dependent": "Coda",
    "pillBoxes": [
      {
        "name": "Morning",
        "frequency": "Daily",
        "pills": [
          {
            "name": "C",
          },
          {
            "name": "Extra Virgin Olive Oil",
          }
        ]
      },
      {
        "name": "Bedtime",
        "frequency": "Daily",
        "pills": [
          {
            "name": "Cinsulin - Cinnamon",
          },
          {
            "name": "Ubiquinol - CoQ10",
          }
        ]
      }
    ]
  };

  group("construction", () {
    test('instantiates a PillBoxSetModel from named constructor', () async {
      expect(pillBoxSetModel.caretaker, equals('Bill'));
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
      expect(result, pillBoxSetMap);
    });
  });
}
