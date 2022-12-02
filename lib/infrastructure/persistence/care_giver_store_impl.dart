import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:pusherman/domain/core/entities/care_giver_entity.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/infrastructure/persistence/care_giver_store.dart';
import 'package:unrepresentable_state/unrepresentable_state.dart';

class CareGiverStoreImpl implements CareGiverStore {
  final logger = Logger(
    printer: PrettyPrinter(printTime: true),
  );

  //TODO(wltiii): this is probably not the right place for db instantiation
  final db = FirebaseFirestore.instance;

  @override
  Future<CareGiverEntity> get(CareGiverEntity careGiver) async {
    final collection = db.collection(CareGiverStore.collection);

    final snapshot = await collection
        .doc(careGiver.entityMetaData.id.value)
        .get()
        .catchError((Object e, StackTrace stackTrace) {
      throw ServerException(
        ExceptionMessage('Error retrieving property. Error was "${e.toString()}"'),
      );
    });

    if (snapshot.exists && snapshot.data()!.isNotEmpty) {
      return CareGiverEntity.fromDocumentSnapshot(snapshot);
    } else {
      throw NotFoundException(
        ExceptionMessage('Organizer with id [${careGiver.entityMetaData.id.value}] was not found'),
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
    // await db.collection(CaregiverStore.collection)
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
  // Future<CaregiverEntity> getByCaregiver(CareGiver caregiver) {
  //   final collection = db.collection(CaregiverStore.collection);
  //
  //   // await db.collection(CaregiverStore.collection)
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
  //     return CaregiverEntity.fromDocumentSnapshot(snapshot);
  //   } else {
  //     throw NotFoundException(
  //       ExceptionMessage(
  //           'Organizer with id [${organizer.entityMetaData.id.value}] was not found'),
  //     );
  //   }
  // }

  @override
  Future<CareGiverEntity> add(CareGiver organizer) async {
    // TODO: implement getByCaregiver
    throw UnimplementedError();
  }

  @override
  Future<void> update(CareGiverEntity organizer) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<CareGiverEntity> delete(CareGiverEntity organizer) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
