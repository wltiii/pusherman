import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pusherman/domain/core/entities/entity.dart';
import 'package:pusherman/domain/core/entities/entity_meta_data.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/organizer.dart';

class OrganizerEntity extends Entity {
  OrganizerEntity({
    required OrganizerEntityMetaData entityMetaData,
    required this.model,
  }) : super(
          entityMetaData: entityMetaData,
          model: model,
        );

  factory OrganizerEntity.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> docRef) {
    final data = docRef..data();

    final entity = OrganizerEntity(
      entityMetaData: OrganizerEntityMetaData(
        id: OrganizerEntityId(docRef.id),
        path: OrganizerEntityPath(docRef.reference.path),
        // path: OrganizerEntityParent(docRef.reference.parent),
      ),
      model: Organizer.fromJson(data.data()!),
    );

    return entity;
  }

  Organizer model;
}

class OrganizerEntityMetaData extends EntityMetaData {
  OrganizerEntityMetaData({
    required OrganizerEntityId id,
    required OrganizerEntityPath path,
  }) : super(
          id: id,
          path: path,
        );
}

class OrganizerEntityId extends EntityId {
  OrganizerEntityId(
    String value,
  ) : super(value);
}

class OrganizerEntityPath extends EntityPath {
  OrganizerEntityPath(
    String value,
  ) : super(value);
}
