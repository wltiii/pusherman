import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/core/error/failure.dart';
import 'package:pusherman/core/network/network_info.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:pusherman/features/schedule/data/repositories/pill_box_set_repository_impl.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockNetworkInfo extends Mock
    implements NetworkInfo {}
class MockLocalDataSource extends Mock
    implements PillBoxSetDataSource {}
class MockRemoteDataSource extends Mock
    implements PillBoxSetDataSource {}

void main() {
  group('PillBoxSetRepositoryImpl', () {
    MockNetworkInfo mockNetworkInfo;
    MockLocalDataSource mockLocalDataSource;
    MockRemoteDataSource mockRemoteDataSource;
    PillBoxSetRepositoryImpl repository;

    final pillBoxSetModel = PillBoxSetModel.fromJson(fixtureAsMap('coda_pill_box_set.json'));
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
          // given
          when(mockRemoteDataSource.getByDependent(dependent))
              .thenAnswer((_) async => pillBoxSet);
          // when
          await repository.getByDependent(dependent);
          // then
          verify(mockLocalDataSource.put(pillBoxSet));
        });

        test('returns ServerFailure when remote and local calls fail', () async {
          // given
          when(mockRemoteDataSource.getByDependent(dependent))
              .thenThrow(ServerException());
          when(mockLocalDataSource.getByDependent(dependent))
              .thenThrow(CacheException());
          // when
          final result = await repository.getByDependent(dependent);
          // then
          verifyNever(mockLocalDataSource.put(any));
          expect(result, equals(Left(ServerFailure())));
        });

        test('returns cached data when remote call fails', () async {
          // given
          when(mockRemoteDataSource.getByDependent(dependent))
              .thenThrow(ServerException());
          when(mockLocalDataSource.getByDependent(dependent))
              .thenAnswer((_) async => pillBoxSet);
          // when
          final result = await repository.getByDependent(dependent);
          // then
          verify(mockLocalDataSource.getByDependent(dependent));
          expect(result, equals(Right(pillBoxSet)));
        });
      });

      group('cachePillBoxSet', () {
        test('saves a PillBoxSet to remote and local', () async {
           // when
          await repository.put(pillBoxSet);
          // then
          verify(mockRemoteDataSource.put(pillBoxSet));
          verify(mockLocalDataSource.put(pillBoxSet));
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
          // given
          when(mockLocalDataSource.getByDependent(dependent))
              .thenThrow(CacheException());
          // when
          final result = await repository.getByDependent(dependent);
          // then
          expect(result, equals(Left(CacheFailure())));
        });
      });

      group('PUT', () {
        test('saves a PillBoxSet to local', () async {
          // when
          await repository.put(pillBoxSet);
          // then
          verify(mockLocalDataSource.put(pillBoxSet));
        });
        test('does not save to remote', () async {
          // when
          await repository.put(pillBoxSet);
          // then
          verifyNever(mockRemoteDataSource.put(pillBoxSet));
        });
      });
    });
  });

}