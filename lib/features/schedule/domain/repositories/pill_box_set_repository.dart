import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pill_box.dart';

abstract class PillBoxSetRepository {
  Future<Either<Failure, PillBox>> getByDependent(String dependent);
  Future<void> put(PillBox pillBoxSet);
}
