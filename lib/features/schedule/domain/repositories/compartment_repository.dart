import 'package:fpdart/fpdart.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/compartment.dart';

abstract class CompartmentRepository {
  Future<Either<Failure, Compartment>> getByCaregiver(CareGiver caregiver);

  Future<Either<Failure, Compartment>> getByDependent(Dependent dependent);

  Future<void> put(Compartment organizer);
}
