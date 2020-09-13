import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pusherman/core/network/network_info.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_local_data_source.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_remote_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
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
          when(mockRemoteDataSource.getByDependent(dependent))
              .thenAnswer((_) async => pillBoxSet);
          // when
          final result = await repository.getByDependent(dependent);
          // then
          verify(mockRemoteDataSource.getByDependent(dependent));
          expect(result, equals(Right(pillBoxSet)));
        });

        test('does not retrieve from local', () async {
          // when
          await repository.getByDependent(dependent);
          // then
          verifyNever(mockLocalDataSource.getByDependent(any));
        });

        test('stores remote result to local', () async {
          throw UnimplementedError();
        });

        test('returns ServerFailure when remote call fails', () async {
          throw UnimplementedError();
        });
      });

      group('cachePillBoxSet', () {
        test('saves a PillBoxSet to remote and local', () async {
          // given
          // final givenPillBoxSet = PillBoxSetModel.fromJson(fixtureAsMap('pill_box_set.json'));

          // when
          await repository.cachePillBoxSet(pillBoxSet);
          // then
          verify(mockRemoteDataSource.cachePillBoxSet(pillBoxSet));
          verify(mockLocalDataSource.cachePillBoxSet(pillBoxSet));
        });
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      group('getByDependent', () {
        test('returns PillBoxSet from local data source', () async {
          // given
          when(mockLocalDataSource.getByDependent(dependent))
              .thenAnswer((_) async => pillBoxSet);
          // when
          final result = await repository.getByDependent(dependent);
          // then
          verify(mockLocalDataSource.getByDependent(dependent));
          expect(result, equals(Right(pillBoxSet)));
        });

        test('does not retrieve from remote', () async {
          // when
          await repository.getByDependent(dependent);
          // then
          verifyNever(mockRemoteDataSource.getByDependent(any));
        });

        test('returns CacheFailure when there is no cached data', () async {
          throw UnimplementedError();
        });
      });

      group('cachePillBoxSet', () {
        test('saves a PillBoxSet to local', () async {
          // given
          // final givenPillBoxSet = PillBoxSetModel.fromJson(fixtureAsMap('pill_box_set.json'));

          // when
          await repository.cachePillBoxSet(pillBoxSet);
          // then
          verify(mockLocalDataSource.cachePillBoxSet(pillBoxSet));
        });
        test('does not save to remote', () async {
          // given
          // final givenPillBoxSet = PillBoxSetModel.fromJson(fixtureAsMap('pill_box_set.json'));

          // when
          await repository.cachePillBoxSet(pillBoxSet);
          // then
          verifyNever(mockRemoteDataSource.cachePillBoxSet(pillBoxSet));
        });
      });
    });
  });

}