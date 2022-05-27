import 'package:pusherman/domain/core/models/types/auth/user.dart';

import '../../domain/core/models/types/treatment_containers/organizer.dart';

abstract class OrganizerDataSource {
  Future<Organizer> getByDependent(Dependent dependent);
  Future<void> put(Organizer organizer);
}
