import 'package:dartz/dartz.dart';

import 'package:pusherman/core/error/failure.dart';

class InputConverter {
  static final InputConverter _instance = InputConverter._();

  factory InputConverter() => _instance;

  InputConverter._();

  Either<Failure, int> toUnsignedInteger(String s) {
    try {
      var i = int.parse(s);
      if (i < 0) throw FormatException();
      return Right(i);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }

  // TODO this probably should error when leading/trailing whitespace, or
  // TODO if any  whitespace. Consider another method for validating
  // TODO user and dependent names
  Either<Failure, String> toWordString(String? s) {
    if (s == null) {
      return Left(InvalidInputFailure());
    }
    var trimmedString = s.trim();
    if (trimmedString.isEmpty) {
      return Left(InvalidInputFailure());
    }
    return Right(trimmedString);
  }
}

class InvalidInputFailure extends Failure {}