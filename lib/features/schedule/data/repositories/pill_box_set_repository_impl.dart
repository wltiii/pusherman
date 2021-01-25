import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/core/error/failure.dart';
import 'package:pusherman/core/network/network_info.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';
import 'package:pusherman/features/schedule/domain/repositories/pill_box_set_repository.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';

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

  // TODO this impl is an "adapter". The abstract class is the port.
  // TODO the above is hexagonal architecture descriptions. in Clean Arch,
  // TODO this impl is an external interface (?) and the abstract class is
  // TODO a gateway (?)
  @override
  Future<void> put(PillBoxSet pillBoxSet) async {
    // TODO does it make map the domain entity to the persistence model here?
    // TODO diagram this and think about it. but, this seems right.
    // TODO NOTE: the following line appears to set they type to the model
    var model = pillBoxSet as PillBoxSetModel;
    await localDataSource.put(pillBoxSet);
    if (await networkInfo.isConnected) {
      await remoteDataSource.put(pillBoxSet);
    }
  }
}