import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/core/error/failure.dart';
import 'package:pusherman/core/network/network_info.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';

import '../../domain/repositories/pill_box_set_repository.dart';

class PillBoxSetRepositoryImpl implements PillBoxSetRepository {
  final NetworkInfo networkInfo;
  final PillBoxSetDataSource localDataSource;
  final PillBoxSetDataSource remoteDataSource;

  PillBoxSetRepositoryImpl({
    @required this.networkInfo,
    @required this.localDataSource,
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, PillBoxSet>> getByDependent(String dependent) async {
    return (await networkInfo.isConnected)
        ? await _getFromRemote(dependent)
        : await _getFromLocal(dependent);
  }

  Future<Either<Failure, PillBoxSet>> _getFromRemote(String dependent) async {
    try {
      PillBoxSetModel pillBoxSet = await remoteDataSource.getByDependent(dependent);
      await put(pillBoxSet);
      return Right(pillBoxSet);
    } on ServerException {
      final Either<Failure, PillBoxSet> result = await _getFromLocal(dependent);
      if (result.isLeft()) {
        return Left(ServerFailure());
      }
      return result;
    }
  }

  Future<Either<Failure, PillBoxSet>> _getFromLocal(String dependent) async {
    try {
      PillBoxSetModel pillBoxSet = await localDataSource.getByDependent(dependent);
      return Right(pillBoxSet);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> put(PillBoxSet pillBoxSet) async {
    await localDataSource.put(pillBoxSet);
    if (await networkInfo.isConnected) {
      await remoteDataSource.put(pillBoxSet);
    }
  }
}