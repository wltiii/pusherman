import 'package:pusherman/domain/core/entities/entity_meta_data.dart';
import 'package:pusherman/domain/core/models/model.dart';

class Entity {
  Entity({required this.entityMetaData, required this.model});

  final EntityMetaData entityMetaData;
  final Model model;
}