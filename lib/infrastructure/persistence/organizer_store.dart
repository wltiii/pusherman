import 'package:pusherman/domain/core/entities/organizer_entity.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/organizer.dart';

abstract class OrganizerStore {
  static const collection = 'organizer';

  Future<OrganizerEntity> get(OrganizerEntity organizer);

  Future<OrganizerEntity> getByDependent(Dependent dependent);

// Future<OrganizerEntity> getByCaregiver(CareGiver caregiver);

  Future<OrganizerEntity> add(Organizer organizer);

  Future<void> update(OrganizerEntity organizer);
}
