import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';

abstract class PillBoxSetRemoteDataSource {
  Future<PillBoxSetModel> getByDependent(String dependent);
  Future<void> cachePillBoxSet(PillBoxSet pillBoxSet);
}

class PillBoxSetRemoteDataSourceImpl implements PillBoxSetRemoteDataSource {
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
