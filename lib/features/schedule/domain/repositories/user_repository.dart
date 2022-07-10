import 'package:fpdart/fpdart.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';

abstract class UserRepository {
  Future<Either<NotFoundFailure, CareGiver>> getByCaregiver(
      CareGiver caregiver);

  Future<Either<NotFoundFailure, Dependent>> getByDependent(
      Dependent dependent);

  Future<void> putCaregiver(CareGiver caretaker);

  Future<void> putDependent(Dependent dependent);
}
