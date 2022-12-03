import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pusherman/application/usecases/usecase.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/features/schedule/domain/repositories/care_giver_repository.dart';

class GetCareGiver implements UseCase<CareGiver, Params> {
  GetCareGiver(this.repository);

  final CareGiverRepository repository;

  @override
  Future<Either<Failure, CareGiver>> call(Params params) async {
    return await repository.get(params.caregiver);
  }
}

class Params extends Equatable {
  final CareGiver caregiver;

  Params(this.caregiver);

  @override
  List<Object> get props => [caregiver];
}
