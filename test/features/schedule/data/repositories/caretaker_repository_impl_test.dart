import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/core/error/failure.dart';
import 'package:pusherman/core/network/network_info.dart';
import 'package:pusherman/features/schedule/data/datasources/caretaker_data_source.dart';
import 'package:pusherman/features/schedule/data/datasources/caretaker_local_data_source.dart';
import 'package:pusherman/features/schedule/data/datasources/caretaker_remote_data_source.dart';
import 'package:pusherman/features/schedule/data/models/caretaker_model.dart';
import 'package:pusherman/features/schedule/data/repositories/caretaker_repository_impl.dart';
import 'package:pusherman/features/schedule/domain/entities/caretaker.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'caretaker_repository_impl_test.mocks.dart';

@GenerateMocks([
  NetworkInfo,
  CaretakerLocalDataSourceImpl,
  CaretakerRemoteDataSourceImpl,
])

void main() {
  var mockNetworkInfo = MockNetworkInfo();
  var mockLocalDataSource = MockCaretakerLocalDataSourceImpl();
  var mockRemoteDataSource = MockCaretakerRemoteDataSourceImpl();
  CaretakerRepositoryImpl repository = CaretakerRepositoryImpl(
    networkInfo: mockNetworkInfo,
    localDataSource: mockLocalDataSource,
    remoteDataSource: mockRemoteDataSource,
  );
  // TODO discuss with Richard
  // TODO may want to use mockito reset() in a global setUp to clear mock
  // TODO collected interactions rather than calling verify on uninteresting
  // TODO interactions, like those added with this commit.
  // TODO SEE: https://pub.dev/documentation/mockito/latest/mockito/reset.html
  // TODO SEE: https://pub.dev/packages/mockito for other possible alternatives
  // TODO such as verifyNoMoreInteractions()
  // TODO this may have become necessary for the global setUp was removed (???)
  setUp(() {
    reset(mockRemoteDataSource);
  });

  group('CaretakerRepositoryImpl', () {
    final caretakerModel = CaretakerModel.fromJson(fixtureAsMap('caretaker.json'));
    final name = caretakerModel.name;
    final Caretaker caretakerEntity = caretakerModel;

    // setUp(() {
    //   reset(mockRemoteDataSource);
    // });
    //
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      group('get', () {
        test('returns Caretaker from remote data source when found', () async {
          // given
          when(mockRemoteDataSource.get(name))
              .thenAnswer((_) async => caretakerModel);
          when(mockRemoteDataSource.put(caretakerModel)).thenAnswer((_) async => Response('', 201));
          // when
          final result = await repository.get(name);
          // then
          verify(mockRemoteDataSource.get(name));
          expect(result, equals(Right(caretakerEntity)));
        });

        test('does not retrieve from local', () async {
          // given
          when(mockRemoteDataSource.get(name))
              .thenAnswer((_) async => caretakerModel);
          when(mockLocalDataSource.put(caretakerModel))
              .thenAnswer((_) async => Response('', 201));
          when(mockRemoteDataSource.put(caretakerModel))
              .thenAnswer((_) async => Response('', 201));
          // when
          await repository.get(name);
          // then
          verifyNever(mockLocalDataSource.get(any));
        });

        // TODO retrieve both local and remote
        // TODO if remote response is out of date:
        // TODO 1) store local to remote
        // TODO 2) return result
        // TODO if local response is out of date:
        // TODO 1) store remote to local
        // TODO 2) return result
        test('stores remote result to local', () async {
          // given
          when(mockRemoteDataSource.get(name))
              .thenAnswer((_) async => caretakerModel);
          when(mockLocalDataSource.put(caretakerModel))
              .thenAnswer((_) async => Response('', 201));
          when(mockRemoteDataSource.put(caretakerModel))
              .thenAnswer((_) async => Response('', 201));
          // when
          await repository.get(name);
          // then
          verify(mockLocalDataSource.put(caretakerModel));
          verify(mockRemoteDataSource.put(caretakerModel));
          verify(mockRemoteDataSource.get(name));
        });

        test('returns ServerFailure when remote and local calls fail', () async {
          // given
          when(mockRemoteDataSource.get(name))
              .thenThrow(ServerException());
          when(mockLocalDataSource.get(name))
              .thenThrow(CacheException());
          // when
          final result = await repository.get(name);
          // then
          verify(mockRemoteDataSource.get(name));
          verifyNever(mockLocalDataSource.put(any));
          expect(result, equals(Left(ServerFailure())));
        });

        test('returns cached data when remote call fails', () async {
          // given
          when(mockRemoteDataSource.get(name))
              .thenThrow(ServerException());
          when(mockLocalDataSource.get(name))
              .thenAnswer((_) async => caretakerModel);
          // when
          final result = await repository.get(name);
          // then
          verify(mockRemoteDataSource.get(name));
          verify(mockLocalDataSource.get(name));
          expect(result, equals(Right(caretakerEntity)));
        });
      });

      group('putCaretaker', () {
        test('saves a Caretaker to remote and local', () async {
          // given
          when(mockRemoteDataSource.put(caretakerModel))
              .thenAnswer((_) async => Response('', 201));

          // when
          await repository.put(caretakerEntity);
          // then
          verify(mockRemoteDataSource.put(caretakerModel));
          verify(mockLocalDataSource.put(caretakerModel));
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
              .thenAnswer((_) async => caretakerModel);
          // when
          final result = await repository.get(name);
          // then
          verify(mockLocalDataSource.get(name));
          expect(result, equals(Right(caretakerEntity)));
        });

        test('does not retrieve from remote', () async {
          // given
          when(mockRemoteDataSource.put(caretakerModel))
              .thenAnswer((_) async => Response('', 201));
          // when
          await repository.get(name);
          // then
          verifyNever(mockRemoteDataSource.get(any));
        });

        test('returns CacheFailure when there is no cached data', () async {
          // given
          when(mockLocalDataSource.get(name))
              .thenThrow(CacheException());
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
          verify(mockLocalDataSource.put(caretakerModel));
        });
        test('does not save to remote', () async {
          // when
          await repository.put(caretakerEntity);
          // then
          verifyNever(mockRemoteDataSource.put(caretakerModel));
        });
      });
    });
  });

}