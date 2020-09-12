//import 'dart:convert';
//import 'dart:math';

//import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_local_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:test/test.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('PillBoxSetLocalDataSource', () {
    PillBoxSetLocalDataSource dataSource ;

    setUp(() {
      dataSource = PillBoxSetLocalDataSourceImpl();
    });

    final Map<String, dynamic> jsonMap = fixtureAsMap('pill_box_set.json');

    group('getByDependent', () {
      test('returns a PillBoxSetModel', () async {
        // given
        final aDependent = 'Coda';
        final expectedPillBoxSet = fixtureAsString('pill_box_set.json');
        // when
        final result = await dataSource.getByDependent(aDependent);
        // then
        expect(result, equals(expectedPillBoxSet));
      });

    });

    group('cachePillBoxSet', () {
      test('caches a PillBoxSetModel', () async {
        // given
        final givenPillBoxSet = PillBoxSetModel.fromJson(fixtureAsMap('pill_box_set.json'));
        // when
        await dataSource.cachePillBoxSet(givenPillBoxSet);
        // then
        // TODO expect exception not thrown, then add verifies
//      expect(result, equals(expectedPillBoxSet));
      });

    });
  });
}
