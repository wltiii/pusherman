// Mocks generated by Mockito 5.0.0 from annotations
// in pusherman/test/features/schedule/presentation/blocs/pill_box_set_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:pusherman/core/error/failure.dart' as _i6;
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart'
    as _i7;
import 'package:pusherman/features/schedule/domain/repositories/pill_box_set_repository.dart'
    as _i2;
import 'package:pusherman/features/schedule/domain/usecases/get_pill_box_set.dart'
    as _i4;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakePillBoxSetRepository extends _i1.Fake
    implements _i2.PillBoxSetRepository {}

class _FakeEither<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetPillBoxSet].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPillBoxSet extends _i1.Mock implements _i4.GetPillBoxSet {
  MockGetPillBoxSet() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PillBoxSetRepository get repository => (super.noSuchMethod(
      Invocation.getter(#repository),
      returnValue: _FakePillBoxSetRepository()) as _i2.PillBoxSetRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.PillBoxSet>> call(
          _i4.Params? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue:
                  Future.value(_FakeEither<_i6.Failure, _i7.PillBoxSet>()))
          as _i5.Future<_i3.Either<_i6.Failure, _i7.PillBoxSet>>);
}
