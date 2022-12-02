import 'package:fpdart/fpdart.dart';
import 'package:pusherman/domain/core/entities/organizer_entity.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';

import '../../../../domain/core/models/types/treatment_containers/organizer.dart';

abstract class OrganizerRepository {
  Future<Either<Failure, OrganizerEntity>> add(Organizer organizer);

  Future<void> delete(OrganizerEntity organizer);

  Future<Either<Failure, Organizer>> get(OrganizerEntity organizer);

  Future<Either<Failure, Organizer>> getByCaregiver(CareGiver caregiver);

  Future<Either<Failure, Organizer>> getByDependent(Dependent dependent);

  Future<Either<Failure, OrganizerEntity>> update(OrganizerEntity organizer);
}
