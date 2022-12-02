import 'package:fpdart/fpdart.dart';
import 'package:pusherman/domain/core/entities/care_giver_entity.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';

abstract class CareGiverRepository {
  Future<Either<Failure, CareGiverEntity>> add(CareGiver careGiver);

  Future<void> delete(CareGiverEntity careGiver);

  Future<Either<Failure, CareGiver>> get(CareGiverEntity careGiver);

  Future<void> update(CareGiverEntity careGiver);
}
