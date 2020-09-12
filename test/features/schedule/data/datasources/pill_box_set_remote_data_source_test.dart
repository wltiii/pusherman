import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_remote_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('PillBoxSetRemoteDataSource', () {
    PillBoxSetRemoteDataSource dataSource ;

    setUp(() {
      dataSource = PillBoxSetRemoteDataSourceImpl();
    });

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
