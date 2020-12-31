import '../models/pill_box_set_model.dart';

abstract class PillBoxSetDataSource {
  Future<PillBoxSetModel> getByDependent(String dependent);
  Future<void> put(PillBoxSetModel pillBoxSet);
}
