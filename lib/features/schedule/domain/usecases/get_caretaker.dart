import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:pusherman/core/error/failure.dart';
import 'package:pusherman/core/usecases/usecase.dart';
import 'package:pusherman/features/schedule/domain/entities/caretaker.dart';
import 'package:pusherman/features/schedule/domain/repositories/caretaker_repository.dart';


class GetCaretaker implements UseCase<Caretaker, Params> {
  final CaretakerRepository repository;

  GetCaretaker(this.repository);

  @override
  Future<Either<Failure, Caretaker>> call(Params params) async {
    return await repository.get(params.name);
  }
}

class Params extends Equatable {
  final String name;

  Params({ required this.name });

  @override
  List<Object> get props => [name];
}