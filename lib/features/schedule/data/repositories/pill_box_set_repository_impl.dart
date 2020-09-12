import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:pusherman/core/error/failure.dart';
import 'package:pusherman/core/network/network_info.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_local_data_source.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_remote_data_source.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';
import '../../domain/repositories/pill_box_set_repository.dart';

class PillBoxSetRepositoryImpl implements PillBoxSetRepository {
  final NetworkInfo networkInfo;
  final PillBoxSetLocalDataSource localDataSource;
  final PillBoxSetRemoteDataSource remoteDataSource;

  PillBoxSetRepositoryImpl({
    @required this.networkInfo,
    @required this.localDataSource,
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, PillBoxSet>> getByDependent(String dependent) async {
    return (await networkInfo.isConnected) ? Right(await remoteDataSource.getByDependent(dependent)) : Right(await localDataSource.getByDependent(dependent));
    // TODO naive implementation
    // PillBoxSet remoteSet = await remoteDataSource.getByDependent(dependent);
    // PillBoxSet localSet = await localDataSource.getByDependent(dependent);
    // return (await networkInfo.isConnected) ? Right(remoteSet) : Right(localSet);
  }

  @override
  Future<void> cachePillBoxSet(PillBoxSet pillBoxSet) async {
    throw UnimplementedError();
  }
}