import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/organizer.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'organizer_data_source.dart';

const CACHED_PILL_BOX_SET = 'CACHED_PILL_BOX_SET_';

class OrganizerLocalDataSourceImpl implements OrganizerDataSource {
  OrganizerLocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<Organizer> getByDependent(Dependent dependent) {
    final cachedOrganizer =
        sharedPreferences.getString(CACHED_PILL_BOX_SET + dependent.name);
    if (cachedOrganizer != null) {
      return Future.value(
          Organizer.fromJson(json.decode(cachedOrganizer)));
    }

    throw NotFoundException();
  }

  @override
  Future<void> put(Organizer model) {
    final key = CACHED_PILL_BOX_SET + model.dependentName;
    final modelAsString = json.encode(model.toJson());
    return sharedPreferences.setString(key, modelAsString);
  }
}