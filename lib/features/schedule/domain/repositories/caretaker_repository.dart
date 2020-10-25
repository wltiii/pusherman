import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/caretaker.dart';


abstract class CaretakerRepository {
  Future<Either<Failure, Caretaker>> get(String name);
  Future<void> put(Caretaker caretaker);
}
