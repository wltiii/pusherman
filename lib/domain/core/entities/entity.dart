import 'package:pusherman/domain/core/entities/entity_meta_data.dart';
import 'package:pusherman/domain/core/models/model.dart';

class Entity {
  Entity({required this.storeMetaData, required this.model});

  final EntityMetaData storeMetaData;
  final Model model;
}
