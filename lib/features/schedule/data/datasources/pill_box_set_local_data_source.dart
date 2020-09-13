import 'package:pusherman/features/schedule/data/datasources/pill_box_set_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';

abstract class PillBoxSetLocalDataSource implements PillBoxSetDataSource {
  Future<PillBoxSetModel> getByDependent(String dependent);
  Future<void> cachePillBoxSet(PillBoxSet pillBoxSet);
}

class PillBoxSetLocalDataSourceImpl implements PillBoxSetLocalDataSource {
  @override
  Future<PillBoxSetModel> getByDependent(String dependent) {
    // TODO: implement getByDependent
    throw UnimplementedError();
  }

  @override
  Future<void> cachePillBoxSet(PillBoxSet pillBoxSet) {
    // TODO: implement cachePillBoxSet
    throw UnimplementedError();
  }

}
