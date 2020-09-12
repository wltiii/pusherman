import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../entities/pill_box_set.dart';
import '../repositories/pill_box_set_repository.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failure.dart';


class GetPillBoxSet implements UseCase<PillBoxSet, Params> {
  final PillBoxSetRepository repository;

  GetPillBoxSet(this.repository);

  @override
  Future<Either<Failure, PillBoxSet>> call(Params params) async {
    return await repository.getByDependent(params.dependent);
  }
}

class Params extends Equatable {
  final String dependent;

  Params({@required this.dependent});

  @override
  List<Object> get props => [dependent];
}
