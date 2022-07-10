import 'package:fpdart/fpdart.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/features/schedule/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;
  final CaregiverDataSource localDataSource;
  final CaregiverDataSource remoteDataSource;

  UserRepositoryImpl({
    @required this.networkInfo,
    @required this.localDataSource,
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, CareGiver>> get(String dependent) async =>
      (await networkInfo.isConnected)
          ? await _getFromRemote(dependent)
          : await _getFromLocal(dependent);

  Future<Either<Failure, CareGiver>> _getFromRemote(String dependent) async {
    try {
      CaregiverModel caretaker = await remoteDataSource.get(dependent);
      await put(caretaker);
      return Right(caretaker);
    } on ServerException {
      final Either<Failure, CareGiver> result = await _getFromLocal(dependent);
      if (result.isLeft()) {
        return Left(ServerFailure());
      }
      return result;
    }
  }

  Future<Either<Failure, CareGiver>> _getFromLocal(String dependent) async {
    try {
      CaregiverModel caretaker = await localDataSource.get(dependent);
      return Right(caretaker);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> put(CareGiver caretaker) async {
    await localDataSource.put(caretaker);
    if (await networkInfo.isConnected) {
      await remoteDataSource.put(caretaker);
    }
  }
}
