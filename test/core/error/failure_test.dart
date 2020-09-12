import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/core/error/failure.dart';

class DummyFailure extends Failure {}

void main() {
  final dummyFailure = DummyFailure();
  final serverFailure = ServerFailure();
  final cacheFailure = CacheFailure();

  group("Equatable", () {
    test('should be a subclass of Equatable entity', () async {
      expect(dummyFailure, isA<Equatable>());
    });

    test('props contains no properties for equality determination', ()
    {
      expect(dummyFailure.props, equals([]));
    });
  });

  group("Implementations", () {
    group("ServerFailure", () {
      test('should be a subclass of Failure entity', () async {
        expect(serverFailure, isA<Failure>());
      });
    });
    
    group("CacheFailure", () {
      test('should be a subclass of Failure entity', () async {
        expect(cacheFailure, isA<Failure>());
      });
    });

  });
}