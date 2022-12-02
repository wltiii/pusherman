import 'package:pusherman/domain/core/entities/care_giver_entity.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';

abstract class CareGiverStore {
  static const collection = 'caregiver';

  Future<CareGiverEntity> add(CareGiver careGiver);

  Future<CareGiverEntity> delete(CareGiverEntity organizer);

  Future<CareGiverEntity> get(CareGiverEntity careGiver);

  // Future<CareGiverEntity> getByDependent(Dependent dependent);

  Future<void> update(CareGiverEntity careGiver);
}
