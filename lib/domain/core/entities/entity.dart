import 'package:pusherman/domain/core/models/value_objects/store_meta_data.dart';

// TODO(wltiii): I know this is wrong. Just discussing a concept with Richard.
// for further info regarding types: https://dart.dev/guides/language/type-system
class Entity<T extends Model> {
  Entity(this.storeMetaData);

  final StoreMetaData storeMetaData;
  final Model<S of T> model;
}