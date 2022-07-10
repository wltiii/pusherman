import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/organizer.dart';

abstract class OrganizerStore {
  static String get collection => 'organizer';

  Future<Organizer> get(Organizer organizer);

  Future<Organizer> getByDependent(Dependent dependent);

  Future<Organizer> getByCaregiver(CareGiver caregiver);

  Future<Organizer> add(Organizer organizer);

  Future<void> update(Organizer organizer);
}
