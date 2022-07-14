import 'package:fpdart/fpdart.dart';
import 'package:pusherman/domain/core/entities/organizer_entity.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/organizer.dart';

abstract class OrganizerRepository {
  Future<Either<Failure, OrganizerEntity>> getByCaregiver(CareGiver caregiver);

  Future<Either<Failure, OrganizerEntity>> getByDependent(Dependent dependent);

  Future<void> put(Organizer organizer);
}
