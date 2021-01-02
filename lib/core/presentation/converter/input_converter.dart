import 'package:dartz/dartz.dart';

import '../../error/failure.dart';

class InputConverter {
  static final InputConverter _instance = InputConverter._();

  factory InputConverter() => _instance;

  InputConverter._() { }

  Either<Failure, int> toUnsignedInteger(String s) {
    try {
      var i = int.parse(s);
      if (i < 0) throw FormatException();
      return Right(i);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, String> toWordString(String s) {
    if (s == null) {
      return Left(InvalidInputFailure());
    }
    String trimmedString = s.trim();
    if (trimmedString.isEmpty) {
      return Left(InvalidInputFailure());
    }
    return Right(trimmedString);
  }
}

class InvalidInputFailure extends Failure {}
