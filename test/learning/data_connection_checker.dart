import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('an instance can be constructed', () {
    final instance = InternetConnectionChecker();
    expect(instance, isNot(null));
    expect(instance, isA<InternetConnectionChecker>());
  });

  test('it can detect a connection', () async {
    final instance = InternetConnectionChecker();
    var result = await instance.hasConnection;
    expect(result, isTrue);
  });
}