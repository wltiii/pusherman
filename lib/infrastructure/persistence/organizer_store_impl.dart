import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:pusherman/domain/core/entities/organizer_entity.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/organizer.dart';
import 'package:pusherman/infrastructure/persistence/organizer_store.dart';
import 'package:unrepresentable_state/unrepresentable_state.dart';

class OrganizerStoreImpl implements OrganizerStore {
  final logger = Logger(
    printer: PrettyPrinter(printTime: true),
  );

  //TODO(wltiii): this is probably not the right place for db instantiation
  final db = FirebaseFirestore.instance;

  @override
  Future<OrganizerEntity> get(OrganizerEntity organizer) async {
    final collection = db.collection(OrganizerStore.collection);

    final snapshot = await collection
        .doc(organizer.entityMetaData.id.value)
        .get()
        .catchError((Object e, StackTrace stackTrace) {
      throw ServerException(
        ExceptionMessage('Error retrieving property. Error was "${e.toString()}"'),
      );
    });

    if (snapshot.exists && snapshot.data()!.isNotEmpty) {
      return OrganizerEntity.fromDocumentSnapshot(snapshot);
    } else {
      throw NotFoundException(
        ExceptionMessage('Organizer with id [${organizer.entityMetaData.id.value}] was not found'),
      );
    }

    // final docRef = db.collection("cities").doc(organizer.id);
    //
    // docRef.get().then(
    //       (DocumentSnapshot doc) {
    //     final data = doc.data() as Map<String, dynamic>;
    //     // ...
    //   },
    //   onError: (e) => print("Error getting document: $e"),
    // );
    //
    // await db.collection(OrganizerStore.collection)
    //     .where(
    //   'uid',
    //   isEqualTo: organizer.id,
    // )
    //     .where(
    //   'userType',
    //   isEqualTo: user.userType,
    // )
    //     .limit(limit)
    //     .get()
    //     .then((snapshot) {
    //   logger.d(
    //       'No of records received from datasource is ${snapshot.docs.length}');
    //   for (final doc in snapshot.docs) {
    //     users.add(
    //       _toAppUser(
    //         doc.id,
    //         doc.data(),
    //       ),
    //     );
    //   }
    // }).catchError((Object e, StackTrace stackTrace) {
    //   logger.e('Error retrieving property. Error was "${e.toString()}"');
    //   throw ServerException();
    // });
    //
    // // TODO this is giving a false return when no user is found
    // // TODO this should really return Future<Either<Exception, AppUser>>
    //
    // if (users.length > 1) {
    //   throw ServerException('Found ${users.length} users. '
    //       'Expected 1. '
    //       'User id ${user.id}. '
    //       'User type is ${user.userType}');
    // } else if (users.isEmpty) {
    //   throw NotFoundException();
    // } else {
    //   return users[0];
    // }
  }

  // @override
  // Future<OrganizerEntity> getByCaregiver(CareGiver caregiver) {
  //   final collection = db.collection(OrganizerStore.collection);
  //
  //   // await db.collection(OrganizerStore.collection)
  //   //     .where(
  //   //   'uid',
  //   //   isEqualTo: organizer.id,
  //   // )
  //   //     .where(
  //   //   'userType',
  //   //   isEqualTo: user.userType,
  //   // )
  //   //     .limit(limit)
  //   //     .get()
  //   //     .then((snapshot) {
  //   //   logger.d(
  //   //       'No of records received from datasource is ${snapshot.docs.length}');
  //   //   for (final doc in snapshot.docs) {
  //   //     users.add(
  //   //       _toAppUser(
  //   //         doc.id,
  //   //         doc.data(),
  //   //       ),
  //   //     );
  //   //   }
  //   // }).catchError((Object e, StackTrace stackTrace) {
  //   //   logger.e('Error retrieving property. Error was "${e.toString()}"');
  //   //   throw ServerException();
  //   // });
  //
  //   final snapshot = await collection
  //       .where()
  //       // .doc(organizer.entityMetaData.id.value)
  //       .get()
  //       .catchError((Object e, StackTrace stackTrace) {
  //     throw ServerException(
  //       ExceptionMessage(
  //           'Error retrieving property. Error was "${e.toString()}"'),
  //     );
  //   });
  //
  //   if (snapshot.exists && snapshot.data()!.isNotEmpty) {
  //     return OrganizerEntity.fromDocumentSnapshot(snapshot);
  //   } else {
  //     throw NotFoundException(
  //       ExceptionMessage(
  //           'Organizer with id [${organizer.entityMetaData.id.value}] was not found'),
  //     );
  //   }
  // }

  @override
  Future<OrganizerEntity> getByDependent(Dependent dependent) {
    // TODO: implement getByDependent
    throw UnimplementedError();
  }

  @override
  Future<OrganizerEntity> add(Organizer organizer) async {
    // TODO: implement getByCaregiver
    throw UnimplementedError();
  }

  @override
  Future<void> update(OrganizerEntity organizer) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
