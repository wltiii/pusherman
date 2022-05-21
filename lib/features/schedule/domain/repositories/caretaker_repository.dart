// import 'package:dartz/dartz.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/types/auth/user.dart';

abstract class CaregiverRepository {
  Future<Either<NotFoundFailure, Caregiver>> get(String name);
  Future<void> put(Caregiver caretaker);
}
