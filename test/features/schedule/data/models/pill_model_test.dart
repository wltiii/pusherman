import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import 'package:pusherman/features/schedule/domain/entities/pill.dart';
import 'package:pusherman/features/schedule/data/models/pill_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final pillModel = PillModel(name: 'Extra Virgin Olive Oil');
  final pillJson = fixtureAsString('pill.json');
  final pillMap = {
    "name": "Extra Virgin Olive Oil",
  };

  group("construction", () {
    test('instantiates a PillModel from named constructor', () async {
      expect(pillModel.name, equals('Extra Virgin Olive Oil'));
    });

    test('should be a subclass of Pill entity', () async {
      expect(pillModel, isA<Pill>());
    });

    test("instantiates from JSON", () async {
      // given
      final Map<String, dynamic> jsonMap = json.decode(pillJson);
      // when
      final result = PillModel.fromJson(jsonMap);
      // then
      expect(result, pillModel);
    });
  });

  group("to JSON", () {
    test("instantiates JSON object from PillModel instance", () async {
      // when
      final result = pillModel.toJson();
      // then
      expect(result, pillMap);
    });
  });
}