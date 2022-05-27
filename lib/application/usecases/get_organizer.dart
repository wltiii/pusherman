import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pusherman/application/usecases/usecase.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/treatment_containers/organizer.dart';
import 'package:pusherman/features/schedule/domain/repositories/organizer_repository.dart';

class GetOrganizer implements UseCase<Organizer, Params> {
  GetOrganizer(this.repository);

  final OrganizerRepository repository;

  @override
  Future<Either<Failure, Organizer>> call(Params params) async {
    return await repository.getByDependent(params.dependent);
  }
}

class Params extends Equatable {
  final Dependent dependent;

  Params(this.dependent);

  @override
  List<Object> get props => [dependent];
}
