import 'package:fpdart/fpdart.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/organizer.dart';
import 'package:pusherman/features/schedule/domain/repositories/organizer_repository.dart';
import 'package:pusherman/infrastructure/persistence/organizer_store.dart';

class OrganizerRepositoryImpl implements OrganizerRepository {
  OrganizerRepositoryImpl(
    this.organizerStore,
  );

  final OrganizerStore organizerStore;

  @override
  Future<Either<Failure, Organizer>> getByDependent(Dependent dependent) async {
    try {
      Organizer organizer = await organizerStore.getByDependent(dependent);
      await put(organizer);
      return Right(organizer);
    } on ServerException {
      final Either<Failure, Organizer> result = await _getFromLocal(dependent);
      if (result.isLeft()) {
        return Left(ServerFailure());
      }
      return result;
    }
  }

  Future<Either<Failure, Organizer>> _getFromRemote(String dependent) async {
    try {
      Organizer organizer = await remoteDataSource.getByDependent(dependent);
      await put(organizer);
      return Right(organizer);
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
      Organizer organizer = await organizerStore.getByDependent(dependent);
      return Right(organizer);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> put(Organizer organizer) async {
    await organizerStore.put(Organizer);
    if (await networkInfo.isConnected) {
      await remoteDataSource.put(Organizer);
    }
  }

  @override
  Future<Either<Failure, Organizer>> getByCaregiver(Caregiver caregiver) {
    // TODO: implement getByCaregiver
    throw UnimplementedError();
  }
}
