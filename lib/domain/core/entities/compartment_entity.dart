import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pusherman/domain/core/entities/entity.dart';
import 'package:pusherman/domain/core/entities/entity_meta_data.dart';

import '../models/types/treatment_containers/compartment.dart';

class CompartmentEntity extends Entity {
  CompartmentEntity({
    required CompartmentEntityMetaData entityMetaData,
    required this.model,
  }) : super(
          entityMetaData: entityMetaData,
          model: model,
        );

  factory CompartmentEntity.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> docRef) {
    final data = docRef..data();

    final entity = CompartmentEntity(
      entityMetaData: CompartmentEntityMetaData(
        id: CompartmentEntityId(docRef.id),
        path: CompartmentEntityPath(docRef.reference.path),
        // path: CompartmentEntityParent(docRef.reference.parent),
      ),
      model: Compartment.fromJson(data.data()!),
    );

    return entity;
  }

  Compartment model;
}

class CompartmentEntityMetaData extends EntityMetaData {
  CompartmentEntityMetaData({
    required CompartmentEntityId id,
    required CompartmentEntityPath path,
  }) : super(
          id: id,
          path: path,
        );
}

class CompartmentEntityId extends EntityId {
  CompartmentEntityId(
    String value,
  ) : super(value);
}

class CompartmentEntityPath extends EntityPath {
  CompartmentEntityPath(
    String value,
  ) : super(value);
}
