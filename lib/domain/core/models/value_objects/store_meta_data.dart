import '../../error/exceptions.dart';
import 'exception_message.dart';
import 'non_empty_string.dart';

/// This class represents some of the metadata contained within a
/// Firestore DocumentReference related to a given Firestore Document.
class StoreMetaData {
  const StoreMetaData({
    required this.id,
    required this.path,
  });

  final StoreId id;
  final StorePath path;
// final StoreParent _parent;
}

/// [StoreId] is a unique identifier of a document.
///
/// It is a [NonEmptyString], thus  must not be empty. Instantiating with an
/// empty String will throw a [ValueException].
///
class StoreId extends NonEmptyString {
  StoreId(String value)
      : super(
          value,
          validators: [
            (String value) => {
                  if (value.trimRight().isEmpty)
                    throw ValueException(
                      ExceptionMessage('Store id must not be empty.'),
                    ),
                },
          ],
        );
}

/// [StorePath] identifies the path of this document (relative to
/// the root of the database) as a slash-separated string.
///
/// It is a [NonEmptyString], thus  must not be empty. Instantiating with an
/// empty String will throw a [ValueException].
///
class StorePath extends NonEmptyString {
  StorePath(String value)
      : super(
          value,
          validators: [
            (String value) => {
                  if (value.trimRight().isEmpty)
                    throw ValueException(
                      ExceptionMessage('Store path must not be empty.'),
                    ),
                },
          ],
        );
}

// TODO(wltiii:) this may not be necessary. As such, it is unimplemented
// CollectionReference and needs to be thought through further.
/// [StoreParent] identifies CollectionReference to the collection that contains
/// this document.
///
/// It is a [NonEmptyString], thus  must not be empty. Instantiating with an
/// empty String will throw a [ValueException].
///
// class StoreParent extends CollectionReference {
//   StoreParent(String value)
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
