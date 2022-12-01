import 'package:unrepresentable_state/unrepresentable_state.dart';

/// This class represents some of the metadata contained within a
/// Firestore DocumentReference related to a given Firestore Document.
abstract class EntityMetaData {
  const EntityMetaData({
    required this.id,
    required this.path,
  });

  final EntityId id;
  final EntityPath path;
// final EntityParent _parent;
}

/// [EntityId] is a unique identifier of a document.
///
/// It is a [NonEmptyString], thus  must not be empty. Instantiating with an
/// empty String will throw a [ValueException].
///
class EntityId extends NonEmptyString {
  EntityId(String value)
      : super(
          value,
          validators: [
            (String value) => {
                  if (value.trimRight().isEmpty)
                    throw ValueException(
                      ExceptionMessage('Entity id must not be empty.'),
                    ),
                },
          ],
        );
}

/// [EntityPath] identifies the path of this document (relative to
/// the root of the database) as a slash-separated string.
///
/// It is a [NonEmptyString], thus  must not be empty. Instantiating with an
/// empty String will throw a [ValueException].
///
class EntityPath extends NonEmptyString {
  EntityPath(String value)
      : super(
          value,
          validators: [
            (String value) => {
                  if (value.trimRight().isEmpty)
                    throw ValueException(
                      ExceptionMessage('Entity path must not be empty.'),
                    ),
                },
          ],
        );
}

// TODO(wltiii:) this may not be necessary. As such, it is unimplemented
// CollectionReference and needs to be thought through further. For now,
// _make it work, make it better_.
/// [EntityParent] identifies CollectionReference to the collection that contains
/// this document.
///
/// It is a [NonEmptyString], thus  must not be empty. Instantiating with an
/// empty String will throw a [ValueException].
///
// class EntityParent extends CollectionReference {
//   EntityParent(String value)
//       : super(
//     value,
//     validators: [
//           (String value) =>
//       {
//         if (value
//             .trimRight()
//             .isEmpty)
//           throw ValueException(
//             ExceptionMessage('User id must not be empty.'),
//           ),
//       },
//     ],
//   );
// }
