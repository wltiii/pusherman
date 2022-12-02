import 'package:fpdart/fpdart.dart';
import 'package:pusherman/domain/core/entities/organizer_entity.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/organizer.dart';
import 'package:pusherman/features/schedule/domain/repositories/organizer_repository.dart';
import 'package:pusherman/infrastructure/persistence/organizer_store.dart';
import 'package:unrepresentable_state/unrepresentable_state.dart';

class OrganizerRepositoryImpl implements OrganizerRepository {
  OrganizerRepositoryImpl(
    this.organizerStore,
  );

  final OrganizerStore organizerStore;

  @override
  Future<Either<Failure, OrganizerEntity>> get(
    OrganizerEntity organizerEntity,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Organizer>> getByDependent(
    Dependent dependent,
  ) async {
    try {
      OrganizerEntity result = await organizerStore.getByDependent(dependent);
      return Right(result.model);
    } on NotFoundException {
      return Left(NotFoundFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, OrganizerEntity>> add(
    Organizer organizer,
  ) async {
    try {
      OrganizerEntity result = await organizerStore.add(organizer);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, OrganizerEntity>> update(OrganizerEntity organizer) async {
    try {
      await organizerStore.update(organizer);
      return Right(organizer);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
