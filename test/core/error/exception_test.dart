import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/core/error/exception.dart';


void main() {
  final serverException = ServerException();
  final cacheException = CacheException();

  group("Implementations", () {
    group("ServerException", () {
      test('should be a subclass of Exception', () async {
        expect(serverException, isA<Exception>());
      });
    });
    
    group("CacheException", () {
      test('should be a subclass of Exception', () async {
        expect(cacheException, isA<Exception>());
      });
    });

  });
}