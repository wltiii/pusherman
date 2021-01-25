import 'package:dartz/dartz.dart';

import 'package:pusherman/core/error/failure.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';


abstract class PillBoxSetRepository {
  Future<Either<Failure, PillBoxSet>> getByDependent(String dependent);
  Future<void> put(PillBoxSet pillBoxSet);
}
