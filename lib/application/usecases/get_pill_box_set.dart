import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../entities/pill_box.dart';
import '../repositories/pill_box_set_repository.dart';
import 'usecase.dart';

class GetPillBoxSet implements UseCase<PillBox, Params> {
  final PillBoxSetRepository repository;

  GetPillBoxSet(this.repository);

  @override
  Future<Either<Failure, PillBox>> call(Params params) async {
    return await repository.getByDependent(params.dependent);
  }
}

class Params extends Equatable {
  final String dependent;

  Params({@required this.dependent});

  @override
  List<Object> get props => [dependent];
}
