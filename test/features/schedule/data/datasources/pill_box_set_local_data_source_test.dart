import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/features/schedule/data/datasources/organizer_data_source.dart';
import 'package:pusherman/features/schedule/data/datasources/organizer_local_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('OrganizerLocalDataSource', () {
    OrganizerDataSource dataSource;
    MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      dataSource = OrganizerLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences,
      );
    });

    group('getByDependent', () {
      test('returns a Organizer', () async {
        // given
        final aDependent = 'Coda';
        final key = CACHED_PILL_BOX_SET + aDependent;
        final expectedOrganizer = Organizer.fromJson(fixtureAsMap('coda_organizer.json'));
        when(mockSharedPreferences.getString(key))
            .thenReturn(fixtureAsString('coda_organizer.json'));
        // when
        final result = await dataSource.getByDependent(aDependent);
        // then
        expect(result, equals(expectedOrganizer));
      });

      test('throws a CacheException when there is no value', () async {
        // given
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // expect
        expect(() => dataSource.getByDependent('unknown'), throwsA(TypeMatcher<CacheException>()));
      });
    });

    group('PUT', () {
      test('creates a Organizer', () async {
        // given
        final givenOrganizer = Organizer.fromJson(fixtureAsMap('coda_organizer.json'));
        final expectedJsonString = json.encode(givenOrganizer);
        // when
        await dataSource.update(givenOrganizer);
        // then
        verify(mockSharedPreferences.setString(
          CACHED_PILL_BOX_SET + givenOrganizer.dependent,
          expectedJsonString,
        ));
      });
    });
  });
}
