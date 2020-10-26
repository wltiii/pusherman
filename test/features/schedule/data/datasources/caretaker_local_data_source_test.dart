import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/features/schedule/data/datasources/caretaker_data_source.dart';
import 'package:pusherman/features/schedule/data/datasources/caretaker_local_data_source.dart';
import 'package:pusherman/features/schedule/data/models/caretaker_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('CaretakerLocalDataSource', () {
    CaretakerDataSource dataSource;
    MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      dataSource = CaretakerLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences,
      );
    });

    group('GET', () {
      test('returns a CaretakerModel', () async {
        // given
        final aDependent = 'Coda';
        final key = CACHED_CARETAKER + aDependent;
        final expectedCaretaker = CaretakerModel.fromJson(fixtureAsMap('caretaker.json'));
        when(mockSharedPreferences.getString(key))
            .thenReturn(fixtureAsString('caretaker.json'));
        // when
        final result = await dataSource.get(aDependent);
        // then
        expect(result, equals(expectedCaretaker));
      });

      test('throws a CacheException when there is no value', () async {
        // given
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // expect
        expect(() => dataSource.get('unknown'), throwsA(TypeMatcher<CacheException>()));
       });

    });

    group('PUT', () {
      test('creates a CaretakerModel', () async {
        // given
        final givenCaretaker = CaretakerModel.fromJson(fixtureAsMap('caretaker.json'));
        final expectedJsonString = json.encode(givenCaretaker);
        // when
        await dataSource.put(givenCaretaker);
        // then
        verify(mockSharedPreferences.setString(
          CACHED_CARETAKER + givenCaretaker.name,
          expectedJsonString,
        ));
      });

    });
  });
}
