import 'package:fpdart/fpdart.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/compartment.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/organizer.dart';

abstract class CompartmentRepository {
  Future<Either<Failure, CompartmentEntity>> add(Compartment compartment);

  Future<void> delete(CompartmentEntity compartmentEntity);

  Future<Either<Failure, Compartment>> getByCaregiver(CompartmentEntity caregiver);

  Future<Either<Failure, Compartment>> getByDependent(Dependent dependent);

  Future<void> update(CompartmentEntity organizer);
}
