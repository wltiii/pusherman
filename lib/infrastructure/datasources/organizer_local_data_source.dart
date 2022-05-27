import '../../domain/core/models/types/auth/user.dart';
import 'organizer_data_source.dart';

const CACHED_PILL_BOX_SET = 'CACHED_PILL_BOX_SET_';

class OrganizerLocalDataSourceImpl implements OrganizerDataSource {
  OrganizerLocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<Organizer> getByDependent(Dependent dependent) {
    final cachedOrganizer =
        sharedPreferences.getString(CACHED_PILL_BOX_SET + dependent);
    if (cachedOrganizer != null) {
      return Future.value(
          OrganizerModel.fromJson(json.decode(cachedOrganizer)));
    }

    throw CacheException();
  }

  @override
  Future<void> put(OrganizerModel model) {
    final key = CACHED_PILL_BOX_SET + model.dependent;
    final modelAsString = json.encode(model.toJson());
    return sharedPreferences.setString(key, modelAsString);
  }
}
