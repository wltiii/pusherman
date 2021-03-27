import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/core/error/failure.dart';
import 'package:pusherman/core/network/network_info.dart';
import 'package:pusherman/features/schedule/domain/entities/caretaker.dart';
import 'package:pusherman/features/schedule/domain/repositories/caretaker_repository.dart';
import 'package:pusherman/features/schedule/data/datasources/caretaker_data_source.dart';
import 'package:pusherman/features/schedule/data/models/caretaker_model.dart';

class CaretakerRepositoryImpl implements CaretakerRepository {
  final NetworkInfo networkInfo;
  final CaretakerDataSource localDataSource;
  final CaretakerDataSource remoteDataSource;

  CaretakerRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Caretaker>> get(String dependent) async => (await networkInfo.isConnected)
        ? await _getFromRemote(dependent)
        : await _getFromLocal(dependent);

  Future<Either<Failure, Caretaker>> _getFromRemote(String dependent) async {
    try {
      // TODO retrieve both local and remote
      // TODO if remote response is out of date:
      // TODO 1) store local to remote
      // TODO 2) return result
      // TODO if local response is out of date:
      // TODO 1) store remote to local
      // TODO 2) return result
      var caretaker = await remoteDataSource.get(dependent);
      await put(caretaker);
      return Right(caretaker);
    } on ServerException {
      final Either<Failure, Caretaker> result = await _getFromLocal(dependent);
      if (result.isLeft()) {
        return Left(ServerFailure());
      }
      return result;
    }
  }

  Future<Either<Failure, Caretaker>> _getFromLocal(String dependent) async {
    try {
      var caretaker = await localDataSource.get(dependent);
      return Right(caretaker);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  // TODO see all notes in PillBoxSetRepositoryImpl
  @override
  Future<void> put(Caretaker caretaker) async {
    var model = caretaker as CaretakerModel;
    await localDataSource.put(caretaker);
    if (await networkInfo.isConnected) {
      await remoteDataSource.put(caretaker);
    }
  }
}