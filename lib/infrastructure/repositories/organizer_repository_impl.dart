import 'package:fpdart/fpdart.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/organizer.dart';
import 'package:pusherman/features/schedule/domain/repositories/organizer_repository.dart';
import 'package:pusherman/infrastructure/datasources/organizer_data_source.dart';

class OrganizerRepositoryImpl implements OrganizerRepository {
  OrganizerRepositoryImpl(
    this.networkInfo,
    this.localDataSource,
    this.remoteDataSource,
  );

  final NetworkInfo networkInfo;
  final OrganizerDataSource localDataSource;
  final OrganizerDataSource remoteDataSource;

  @override
  Future<Either<Failure, Organizer>> getByDependent(Dependent dependent) async {
    return (await networkInfo.isConnected)
        ? await _getFromRemote(dependent)
        : await _getFromLocal(dependent);
  }

  Future<Either<Failure, Organizer>> _getFromRemote(String dependent) async {
    try {
      OrganizerModel Organizer =
          await remoteDataSource.getByDependent(dependent);
      await put(Organizer);
      return Right(Organizer);
    } on ServerException {
      final Either<Failure, Organizer> result = await _getFromLocal(dependent);
      if (result.isLeft()) {
        return Left(ServerFailure());
      }
      return result;
    }
  }

  Future<Either<Failure, Organizer>> _getFromLocal(String dependent) async {
    try {
      OrganizerModel Organizer =
          await localDataSource.getByDependent(dependent);
      return Right(Organizer);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> put(Organizer Organizer) async {
    await localDataSource.put(Organizer);
    if (await networkInfo.isConnected) {
      await remoteDataSource.put(Organizer);
    }
  }
}
