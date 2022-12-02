import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pusherman/domain/core/entities/entity.dart';
import 'package:pusherman/domain/core/entities/entity_meta_data.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';

class CareGiverEntity extends Entity {
  CareGiverEntity({
    required CaregiverEntityMetaData entityMetaData,
    required this.model,
  }) : super(
          entityMetaData: entityMetaData,
          model: model,
        );

  factory CareGiverEntity.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> docRef) {
    final data = docRef..data();

    final entity = CareGiverEntity(
      entityMetaData: CaregiverEntityMetaData(
        id: CaregiverEntityId(docRef.id),
        path: CaregiverEntityPath(docRef.reference.path),
        // path: CaregiverEntityParent(docRef.reference.parent),
      ),
      model: CareGiver.fromJson(data.data()!),
    );

    return entity;
  }

  CareGiver model;
}

class CaregiverEntityMetaData extends EntityMetaData {
  CaregiverEntityMetaData({
    required CaregiverEntityId id,
    required CaregiverEntityPath path,
  }) : super(
          id: id,
          path: path,
        );
}

class CaregiverEntityId extends EntityId {
  CaregiverEntityId(
    String value,
  ) : super(value);
}

class CaregiverEntityPath extends EntityPath {
  CaregiverEntityPath(
    String value,
  ) : super(value);
}
