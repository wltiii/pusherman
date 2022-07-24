import 'package:pusherman/domain/core/models/types/auth/user.dart';

abstract class UserDataSource {
  Future<CareGiver> getCaregiver(String name);

  Future<void> put(CareGiver caregiver);

  Future<Dependent> getDependent(String name);

  Future<void> putDependent(Dependent dependent);
}