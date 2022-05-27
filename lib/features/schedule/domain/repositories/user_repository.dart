import 'package:fpdart/fpdart.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';

abstract class UserRepository {
  Future<Either<NotFoundFailure, Caregiver>> getByCaregiver(
      Caregiver caregiver);
  Future<Either<NotFoundFailure, Dependent>> getByDependent(
      Dependent dependent);
  Future<void> putCaregiver(Caregiver caretaker);
  Future<void> putDependent(Dependent dependent);
}
