import 'package:pusherman/domain/core/entities/entity.dart';
import 'package:pusherman/domain/core/entities/entity_meta_data.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/organizer.dart';

class OrganizerEntity extends Entity {
  OrganizerEntity({
    required OrganizerEntityMetaData storeMetaData,
    required Organizer model,
  }) : super(
          storeMetaData: storeMetaData,
          model: model,
        );
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
