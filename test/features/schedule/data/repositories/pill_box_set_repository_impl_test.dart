import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/core/error/failure.dart';
import 'package:pusherman/core/network/network_info.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_local_data_source.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_remote_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:pusherman/features/schedule/data/repositories/pill_box_set_repository_impl.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';

import '../../../../fixtures/fixture_reader.dart';

import 'pill_box_set_repository_impl_test.mocks.dart';

@GenerateMocks([
  NetworkInfo,
  PillBoxSetLocalDataSourceImpl,
  PillBoxSetRemoteDataSourceImpl,
])

void main() {
  // TODO discuss with Richard
  // TODO may want to use mockito reset() in a global setUp to clear mock
  // TODO collected interactions rather than calling verify on uninteresting
  // TODO interactions, like those added with this commit.
  // TODO SEE: https://pub.dev/documentation/mockito/latest/mockito/reset.html
  // TODO SEE: https://pub.dev/packages/mockito for other possible alternatives
  // TODO such as verifyNoMoreInteractions()
  // TODO this may have become necessary for the global setUp was removed (???)
  group('PillBoxSetRepositoryImpl', () {
    var mockNetworkInfo = MockNetworkInfo();
    var mockLocalDataSource = MockPillBoxSetLocalDataSourceImpl();
    var mockRemoteDataSource = MockPillBoxSetRemoteDataSourceImpl();
    PillBoxSetRepositoryImpl repository = PillBoxSetRepositoryImpl(
      networkInfo: mockNetworkInfo,
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
    );

    final pillBoxSetModel = PillBoxSetModel.fromJson(fixtureAsMap('coda_pill_box_set.json'));
    final dependent = pillBoxSetModel.dependent;
    final PillBoxSet pillBoxSet = pillBoxSetModel;

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      group('getByDependent', () {
        test('returns PillBoxSet from remote data source when found', () async {
          // given
          when(mockRemoteDataSource.getByDependent(dependent))
              .thenAnswer((_) async => pillBoxSetModel);
          when(mockRemoteDataSource.put(pillBoxSetModel)).thenAnswer((_) async => Response('', 201));

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
              .thenAnswer((_) async => pillBoxSetModel);
          // when
          await repository.getByDependent(dependent);
          // then
          verify(mockLocalDataSource.put(pillBoxSetModel));
          verify(mockRemoteDataSource.getByDependent(dependent));
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
          verify(mockRemoteDataSource.getByDependent(dependent));
          verifyNever(mockLocalDataSource.put(any));
          expect(result, equals(Left(ServerFailure())));
        });

        test('returns cached data when remote call fails', () async {
          // given
          when(mockRemoteDataSource.getByDependent(dependent))
              .thenThrow(ServerException());
          when(mockLocalDataSource.getByDependent(dependent))
              .thenAnswer((_) async => pillBoxSetModel);
          // when
          final result = await repository.getByDependent(dependent);
          // then
          verify(mockRemoteDataSource.getByDependent(dependent));
          verify(mockLocalDataSource.getByDependent(dependent));
          expect(result, equals(Right(pillBoxSet)));
        });
      });

      group('cachePillBoxSet', () {
        test('saves a PillBoxSet to remote and local', () async {
           // when
          await repository.put(pillBoxSet);
          // then
          verify(mockRemoteDataSource.put(pillBoxSetModel));
          verify(mockLocalDataSource.put(pillBoxSetModel));
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
              .thenAnswer((_) async => pillBoxSetModel);
          // when
          final result = await repository.getByDependent(dependent);
          // then
          verify(mockLocalDataSource.getByDependent(dependent));
          expect(result, equals(Right(pillBoxSet)));
        });

        test('does not retrieve from remote', () async {
          // given
          when(mockLocalDataSource.getByDependent(dependent))
              .thenAnswer((_) async => pillBoxSetModel);
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
          verify(mockLocalDataSource.put(pillBoxSetModel));
        });
        test('does not save to remote', () async {
          // when
          await repository.put(pillBoxSet);
          // then
          verifyNever(mockRemoteDataSource.put(pillBoxSetModel));
        });
      });
    });
  });

}