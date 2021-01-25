import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('an instance can be constructed', () {
    final instance = DataConnectionChecker();
    expect(instance, isNot(null));
    expect(instance, isA<DataConnectionChecker>());
  });

  test('it can detect a connection', () async {
    final instance = DataConnectionChecker();
    var result = await instance.hasConnection;
    expect(result, isTrue);
  });
}