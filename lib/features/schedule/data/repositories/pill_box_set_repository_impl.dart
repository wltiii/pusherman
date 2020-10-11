import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/core/error/failure.dart';
import 'package:pusherman/core/network/network_info.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_data_source.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_remote_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';

import '../../domain/repositories/pill_box_set_repository.dart';

class PillBoxSetRepositoryImpl implements PillBoxSetRepository {
  final NetworkInfo networkInfo;
  final PillBoxSetDataSource localDataSource;
  final PillBoxSetRemoteDataSource remoteDataSource;

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
      // TODO why is this saving
      await cachePillBoxSet(pillBoxSet);
      return Right(pillBoxSet);
    } on ServerException {
      // TODO call local
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, PillBoxSet>> _getFromLocal(String dependent) async {
    try {
      PillBoxSetModel pillBoxSet = await localDataSource.getByDependent(dependent);
      return Right(pillBoxSet);
    } on CacheException {
      // TODO return default
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, PillBoxSet>> _getByDependent(String dependent, PillBoxSetDataSource dataSource)  async {
    return Right(await dataSource.getByDependent(dependent));
  }

  @override
  Future<void> cachePillBoxSet(PillBoxSet pillBoxSet) async {
    await localDataSource.cachePillBoxSet(pillBoxSet);
    if (await networkInfo.isConnected) {
      await remoteDataSource.cachePillBoxSet(pillBoxSet);
    }
  }
}