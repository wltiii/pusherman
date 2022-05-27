import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pusherman/application/usecases/usecase.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/features/schedule/domain/repositories/user_repository.dart';

class GetCaregiver implements UseCase<Caregiver, Params> {
  GetCaregiver(this.repository);

  final UserRepository repository;

  @override
  Future<Either<Failure, Caregiver>> call(Params params) async {
    return await repository.getByCaregiver(params.caregiver);
  }
}

class Params extends Equatable {
  final Caregiver caregiver;

  Params(this.caregiver);

  @override
  List<Object> get props => [caregiver];
}
