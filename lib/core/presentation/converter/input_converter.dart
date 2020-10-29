import 'package:dartz/dartz.dart';

import '../../error/failure.dart';

class InputConverter {
  Either<Failure, int> toUnsignedInteger(String s) {
    try {
      var i = int.parse(s);
      if (i < 0) throw FormatException();
      return Right(i);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
