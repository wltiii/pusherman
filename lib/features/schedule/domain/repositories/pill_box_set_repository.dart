import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pill_box_set.dart';


abstract class PillBoxSetRepository {
  Future<Either<Failure, PillBoxSet>> getByDependent(String dependent);
}
