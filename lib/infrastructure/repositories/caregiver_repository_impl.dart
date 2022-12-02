import 'package:fpdart/fpdart.dart';
import 'package:pusherman/domain/core/entities/care_giver_entity.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/features/schedule/domain/repositories/care_giver_repository.dart';
import 'package:unrepresentable_state/unrepresentable_state.dart';

import '../persistence/care_giver_store.dart';

class CareGiverRepositoryImpl implements CareGiverRepository {
  CareGiverRepositoryImpl(
    this.careGiverStore,
  );

  final CareGiverStore careGiverStore;

  @override
  Future<Either<Failure, CareGiverEntity>> add(CareGiver careGiver) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete(CareGiverEntity careGiver) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CareGiver>> get(CareGiverEntity careGiver) async {
    try {
      CareGiverEntity result = await careGiverStore.get(careGiver);
      return Right(result.model);
    } on NotFoundException {
      return Left(NotFoundFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> update(CareGiverEntity careGiver) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
