import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/core/error/failure.dart';
import 'package:pusherman/core/network/network_info.dart';
import 'package:pusherman/features/schedule/data/datasources/organizer_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:pusherman/features/schedule/data/repositories/treatment_repository_impl.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockLocalDataSource extends Mock implements OrganizerDataSource {}

class MockRemoteDataSource extends Mock implements OrganizerDataSource {}

void main() {
  group('OrganizerRepositoryImpl', () {
    MockNetworkInfo mockNetworkInfo;
    MockLocalDataSource mockLocalDataSource;
    MockRemoteDataSource mockRemoteDataSource;
    OrganizerRepositoryImpl repository;

    final OrganizerModel =
        OrganizerModel.fromJson(fixtureAsMap('coda_organizer.json'));
    final dependent = OrganizerModel.dependent;
    final Organizer Organizer = OrganizerModel;

    setUp(() {
      mockNetworkInfo = MockNetworkInfo();
      mockLocalDataSource = MockLocalDataSource();
      mockRemoteDataSource = MockRemoteDataSource();
      repository = OrganizerRepositoryImpl(
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
        test('returns Organizer from remote data source when found', () async {
          // given
          when(mockRemoteDataSource.getByDependent(dependent))
              .thenAnswer((_) async => Organizer);
          // when
          final result = await repository.getByDependent(dependent);
          // then
          verify(mockRemoteDataSource.getByDependent(dependent));
          expect(result, equals(Right(Organizer)));
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
              .thenAnswer((_) async => Organizer);
          // when
          await repository.getByDependent(dependent);
          // then
          verify(mockLocalDataSource.put(Organizer));
        });

        test('returns ServerFailure when remote and local calls fail',
            () async {
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
              .thenAnswer((_) async => Organizer);
          // when
          final result = await repository.getByDependent(dependent);
          // then
          verify(mockLocalDataSource.getByDependent(dependent));
          expect(result, equals(Right(Organizer)));
        });
      });

      group('cacheOrganizer', () {
        test('saves a Organizer to remote and local', () async {
          // when
          await repository.put(Organizer);
          // then
          verify(mockRemoteDataSource.put(Organizer));
          verify(mockLocalDataSource.put(Organizer));
        });
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      group('getByDependent', () {
        test('returns Organizer from local data source', () async {
          // given
          when(mockLocalDataSource.getByDependent(dependent))
              .thenAnswer((_) async => Organizer);
          // when
          final result = await repository.getByDependent(dependent);
          // then
          verify(mockLocalDataSource.getByDependent(dependent));
          expect(result, equals(Right(Organizer)));
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
        test('saves a Organizer to local', () async {
          // when
          await repository.put(Organizer);
          // then
          verify(mockLocalDataSource.put(Organizer));
        });
        test('does not save to remote', () async {
          // when
          await repository.put(Organizer);
          // then
          verifyNever(mockRemoteDataSource.put(Organizer));
        });
      });
    });
  });
}
