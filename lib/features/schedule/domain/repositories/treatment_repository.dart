import 'package:fpdart/fpdart.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment/treatment.dart';

abstract class TreatmentRepository {
  Future<Either<Failure, Treatment>> getByCaregiver(Caregiver caregiver);
  Future<Either<Failure, Treatment>> getByDependent(Dependent dependent);
  Future<void> put(Treatment treatment);
}
