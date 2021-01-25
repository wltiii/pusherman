import 'package:dartz/dartz.dart';

import 'package:pusherman/core/error/failure.dart';
import 'package:pusherman/features/schedule/domain/entities/caretaker.dart';


abstract class CaretakerRepository {
  Future<Either<Failure, Caretaker>> get(String name);
  Future<void> put(Caretaker caretaker);
}
