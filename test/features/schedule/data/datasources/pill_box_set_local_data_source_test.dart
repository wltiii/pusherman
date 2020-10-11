import 'package:mockito/mockito.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_data_source.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_local_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('PillBoxSetLocalDataSource', () {
    PillBoxSetDataSource dataSource;
    MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      dataSource = PillBoxSetLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences,
      );
    });

    group('getByDependent', () {
      test('returns a PillBoxSetModel', () async {
        // given
        final aDependent = 'Coda';
        final key = CACHED_PILL_BOX_SET + aDependent;
        final expectedPillBoxSet = PillBoxSetModel.fromJson(fixtureAsMap('pill_box_set.json'));
        when(mockSharedPreferences.getString(key))
            .thenReturn(fixtureAsString('pill_box_set.json'));
        // when
        final result = await dataSource.getByDependent(aDependent);
        // then
        expect(result, equals(expectedPillBoxSet));
      });

      test('throws a CacheException when there is no value', () async {
        // given
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // expect
        expect(() => dataSource.getByDependent('unknown'), throwsA(TypeMatcher<CacheException>()));
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
