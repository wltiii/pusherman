import '../../domain/core/models/types/auth/user.dart';

abstract class UserDataSource {
  Future<Caregiver> getCaregiver(String name);
  Future<void> put(Caregiver caregiver);
  Future<Dependent> getDependent(String name);
  Future<void> putDependent(Dependent dependent);
}
