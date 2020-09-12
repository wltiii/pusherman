import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_model.dart';
import 'package:pusherman/features/schedule/data/models/pill_model.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final vitaminC = PillModel(name: "C");
  final evoo = PillModel(name: "Extra Virgin Olive Oil");

  final pills = [vitaminC, evoo];

  final pillBoxModel =
    PillBoxModel(name: 'Morning', frequency: "Daily", pills: pills);

  final pillBoxJson = fixtureAsString('pill_box.json');

  final pillBoxMap = {
    "name": "Morning",
    "frequency": "Daily",
    "pills": [
      {"name": "C"},
      {"name": "Extra Virgin Olive Oil"},
    ],
  };

  group("construction", () {
    test('instantiates a PillBoxModel from named constructor', () async {
      expect(pillBoxModel.name, equals('Morning'));
      expect(pillBoxModel.frequency, equals('Daily'));
      expect(pillBoxModel.pills, equals(pills));
    });

    test('should be a subclass of PillBox entity', () async {
      expect(pillBoxModel, isA<PillBox>());
    });

    test("instantiates from JSON", () async {
      // given
      final Map<String, dynamic> jsonMap = json.decode(pillBoxJson);
      // when
      final result = PillBoxModel.fromJson(jsonMap);
      // then
      expect(result, pillBoxModel);
    });
  });

  group("to JSON", () {
    test("instantiates JSON from object", () async {
      // when
      final result = pillBoxModel.toJson();

      // then
      expect(result, pillBoxMap);
    });
  });
}
