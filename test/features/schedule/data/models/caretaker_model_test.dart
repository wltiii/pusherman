import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/features/schedule/data/models/caretaker_model.dart';
import 'package:pusherman/features/schedule/domain/entities/caretaker.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final dependents = ['Bill', 'Coda'];

  final caretakerModel = CaretakerModel(name: 'Bill', dependents: dependents);

  final caretakerJson = fixtureAsString('caretaker.json');

  final caretakerMap = {
    "name": "Bill",
    "dependents": [
      "Bill",
      "Coda",
    ],
  };

  group("construction", () {
    test('instantiates a CaretakerModel from named constructor', () async {
      expect(caretakerModel.name, equals('Bill'));
      expect(caretakerModel.dependents, equals(dependents));
    });

    test('should be a subclass of Caretaker entity', () async {
      expect(caretakerModel, isA<Caregiver>());
    });

    test("instantiates from JSON", () async {
      // given
      final Map<String, dynamic> jsonMap = json.decode(caretakerJson);
      // when
      final result = CaretakerModel.fromJson(jsonMap);
      // then
      expect(result, caretakerModel);
    });
  });

  group("to JSON", () {
    test("instantiates JSON from object", () async {
      // when
      final result = caretakerModel.toJson();

      // then
      expect(result, caretakerMap);
    });
  });
}
