import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/caretaker.dart';
import '../../domain/repositories/caretaker_repository.dart';
import '../datasources/caretaker_data_source.dart';
import '../models/caretaker_model.dart';

class CaretakerRepositoryImpl implements CaretakerRepository {
  final NetworkInfo networkInfo;
  final CaretakerDataSource localDataSource;
  final CaretakerDataSource remoteDataSource;

  CaretakerRepositoryImpl({
    @required this.networkInfo,
    @required this.localDataSource,
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Caretaker>> get(String dependent) async => (await networkInfo.isConnected)
        ? await _getFromRemote(dependent)
        : await _getFromLocal(dependent);

  Future<Either<Failure, Caretaker>> _getFromRemote(String dependent) async {
    try {
      CaretakerModel caretaker = await remoteDataSource.get(dependent);
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
      CaretakerModel caretaker = await localDataSource.get(dependent);
      return Right(caretaker);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> put(Caretaker caretaker) async {
    await localDataSource.put(caretaker);
    if (await networkInfo.isConnected) {
      await remoteDataSource.put(caretaker);
    }
  }
}