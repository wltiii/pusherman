import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pusherman/core/network/network_info.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_local_data_source.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_remote_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_model.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:pusherman/features/schedule/data/models/pill_model.dart';
import 'package:pusherman/features/schedule/data/repositories/pill_box_set_repository_impl.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockNetworkInfo extends Mock
    implements NetworkInfo {}
class MockLocalDataSource extends Mock
    implements PillBoxSetLocalDataSource {}
class MockRemoteDataSource extends Mock
    implements PillBoxSetRemoteDataSource {}

void main() {
  group('PillBoxSetRepositoryImpl', () {
    MockNetworkInfo mockNetworkInfo;
    MockLocalDataSource mockLocalDataSource;
    MockRemoteDataSource mockRemoteDataSource;
    PillBoxSetRepositoryImpl repository;

    final pillBoxSetModel = PillBoxSetModel.fromJson(fixtureAsMap('pill_box_set.json'));
    final dependent = pillBoxSetModel.dependent;
    final PillBoxSet pillBoxSet = pillBoxSetModel;

    setUp(() {
      mockNetworkInfo = MockNetworkInfo();
      mockLocalDataSource = MockLocalDataSource();
      mockRemoteDataSource = MockRemoteDataSource();
      repository = PillBoxSetRepositoryImpl(
        networkInfo: mockNetworkInfo,
          localDataSource: mockLocalDataSource,
          remoteDataSource: mockRemoteDataSource,
      );
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      group('getByDependent', () {
        test('returns PillBoxSet from remote data source when found', () async {
          // given
          when(mockRemoteDataSource.getByDependent(dependent)).thenAnswer((
              _) async => pillBoxSet);
          // when
          final result = await repository.getByDependent(dependent);
          // then
          verify(mockLocalDataSource.getByDependent(dependent));
          expect(result, equals(Right(pillBoxSet)));
        });

        test('does not retrieve from local data when online', () async {
          // when
          await repository.getByDependent(dependent);
          // then
          verifyNever(mockLocalDataSource.getByDependent(any));
        });
      });
      // });

      group('cachePillBoxSet', () {
        test('saves a PillBoxSet', () async {
          // given
          // final givenPillBoxSet = PillBoxSetModel.fromJson(fixtureAsMap('pill_box_set.json'));

          // when
          final result = await repository.cachePillBoxSet(pillBoxSet);
          // then
          // expect(result, equals(Right(expectedPillBoxSet)));
        });
      });
    });

    group('device is offline', () {
      setUp((){
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

    });
  });

}