import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/core/error/failure.dart';
import 'package:pusherman/core/network/network_info.dart';
import 'package:pusherman/features/schedule/data/datasources/user_data_source.dart';
import 'package:pusherman/features/schedule/data/models/caretaker_model.dart';
import 'package:pusherman/features/schedule/data/repositories/user_repository_impl.dart';
import 'package:pusherman/features/schedule/domain/entities/caretaker.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockLocalDataSource extends Mock implements CaretakerDataSource {}

class MockRemoteDataSource extends Mock implements CaretakerDataSource {}

void main() {
  group('CaretakerRepositoryImpl', () {
    MockNetworkInfo mockNetworkInfo;
    MockLocalDataSource mockLocalDataSource;
    MockRemoteDataSource mockRemoteDataSource;
    CaretakerRepositoryImpl repository;

    final caretakerModel =
        CaretakerModel.fromJson(fixtureAsMap('caretaker.json'));
    final name = caretakerModel.name;
    final Caregiver caretakerEntity = caretakerModel;

    setUp(() {
      mockNetworkInfo = MockNetworkInfo();
      mockLocalDataSource = MockLocalDataSource();
      mockRemoteDataSource = MockRemoteDataSource();
      repository = CaretakerRepositoryImpl(
        networkInfo: mockNetworkInfo,
        localDataSource: mockLocalDataSource,
        remoteDataSource: mockRemoteDataSource,
      );
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      group('get', () {
        test('returns Caretaker from remote data source when found', () async {
          // given
          when(mockRemoteDataSource.get(name))
              .thenAnswer((_) async => caretakerEntity);
          // when
          final result = await repository.get(name);
          // then
          verify(mockRemoteDataSource.get(name));
          expect(result, equals(Right(caretakerEntity)));
        });

        test('does not retrieve from local', () async {
          // when
          await repository.get(name);
          // then
          verifyNever(mockLocalDataSource.get(any));
        });

        test('stores remote result to local', () async {
          // given
          when(mockRemoteDataSource.get(name))
              .thenAnswer((_) async => caretakerEntity);
          // when
          await repository.get(name);
          // then
          verify(mockLocalDataSource.put(caretakerEntity));
        });

        test('returns ServerFailure when remote and local calls fail',
            () async {
          // given
          when(mockRemoteDataSource.get(name)).thenThrow(ServerException());
          when(mockLocalDataSource.get(name)).thenThrow(CacheException());
          // when
          final result = await repository.get(name);
          // then
          verifyNever(mockLocalDataSource.put(any));
          expect(result, equals(Left(ServerFailure())));
        });

        test('returns cached data when remote call fails', () async {
          // given
          when(mockRemoteDataSource.get(name)).thenThrow(ServerException());
          when(mockLocalDataSource.get(name))
              .thenAnswer((_) async => caretakerEntity);
          // when
          final result = await repository.get(name);
          // then
          verify(mockLocalDataSource.get(name));
          expect(result, equals(Right(caretakerEntity)));
        });
      });

      group('putCaretaker', () {
        test('saves a Caretaker to remote and local', () async {
          // when
          await repository.put(caretakerEntity);
          // then
          verify(mockRemoteDataSource.put(caretakerEntity));
          verify(mockLocalDataSource.put(caretakerEntity));
        });
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      group('get', () {
        test('returns Caretaker from local data source', () async {
          // given
          when(mockLocalDataSource.get(name))
              .thenAnswer((_) async => caretakerEntity);
          // when
          final result = await repository.get(name);
          // then
          verify(mockLocalDataSource.get(name));
          expect(result, equals(Right(caretakerEntity)));
        });

        test('does not retrieve from remote', () async {
          // when
          await repository.get(name);
          // then
          verifyNever(mockRemoteDataSource.get(any));
        });

        test('returns CacheFailure when there is no cached data', () async {
          // given
          when(mockLocalDataSource.get(name)).thenThrow(CacheException());
          // when
          final result = await repository.get(name);
          // then
          expect(result, equals(Left(CacheFailure())));
        });
      });

      group('PUT', () {
        test('saves a Caretaker to local', () async {
          // when
          await repository.put(caretakerEntity);
          // then
          verify(mockLocalDataSource.put(caretakerEntity));
        });
        test('does not save to remote', () async {
          // when
          await repository.put(caretakerEntity);
          // then
          verifyNever(mockRemoteDataSource.put(caretakerEntity));
        });
      });
    });
  });
}
