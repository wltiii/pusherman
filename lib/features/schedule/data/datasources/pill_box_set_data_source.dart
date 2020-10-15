import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';

abstract class PillBoxSetDataSource {
  Future<PillBoxSetModel> getByDependent(String dependent);
  Future<void> put(PillBoxSetModel pillBoxSet);
}
