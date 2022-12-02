import 'package:fpdart/fpdart.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';
import 'package:pusherman/features/schedule/domain/repositories/treatment_repository.dart';

class TreatmentRepositoryImpl implements TreatmentRepository {
  TreatmentRepositoryImpl(
    this.networkInfo,
    this.localDataSource,
    this.remoteDataSource,
  );

  final NetworkInfo networkInfo;
  final TreatmentDataSource localDataSource;
  final TreatmentDataSource remoteDataSource;

  @override
  Future<Either<Failure, Treatment>> getByDependent(Dependent dependent) async {
    return (await networkInfo.isConnected)
        ? await _getFromRemote(dependent)
        : await _getFromLocal(dependent);
  }

  Future<Either<Failure, Treatment>> _getFromRemote(String dependent) async {
    try {
      TreatmentModel Treatment = await remoteDataSource.getByDependent(dependent);
      await update(Treatment);
      return Right(Treatment);
    } on ServerException {
      final Either<Failure, Treatment> result = await _getFromLocal(dependent);
      if (result.isLeft()) {
        return Left(ServerFailure());
      }
      return result;
    }
  }

  Future<Either<Failure, Treatment>> _getFromLocal(String dependent) async {
    try {
      TreatmentModel Treatment = await localDataSource.getByDependent(dependent);
      return Right(Treatment);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> update(Treatment Treatment) async {
    await localDataSource.update(Treatment);
    if (await networkInfo.isConnected) {
      await remoteDataSource.update(Treatment);
    }
  }
}
