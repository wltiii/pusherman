import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/type_defs.dart';

class UserTester extends User {
  const UserTester(UserId id, UserName name) : super(id, name);

  factory UserTester.fromJson(String source) {
    final map = json.decode(source) as Map<String, Object?>;

    return UserTester(
      UserId(map['id'] as String),
      UserName(map['userName'] as String),
    );
  }

  Json toJson() {
    return super.toJson();
  }
}

void main() {
  group('construction', () {
    test('all User types constructed', () {

      final tester = UserTester(UserId('uid'), UserName('jack'));
      expect(tester, isA<User>());
      expect(tester, isA<Equatable>());
      expect(tester.id, equals('uid'));
      expect(tester.name, equals('jack'));

      final dependent = Dependent(UserId('uid'), UserName('jack'));
      expect(dependent.id, equals(tester.id));
      expect(dependent.name, equals(tester.name));

      final careGiver = CareGiver(UserId('uid'), UserName('jack'));
      expect(careGiver.id, equals(tester.id));
      expect(careGiver.name, equals(tester.name));

      final careProvider = CareProvider(UserId('uid'), UserName('jack'));
      expect(careProvider.id, equals(tester.id));
      expect(careProvider.name, equals(tester.name));
    });

    test('when id is empty string exception is thrown', () {
      expect(
            () => UserTester(UserId(''), UserName('jack')),
        throwsA(
          predicate(
                (e) =>
            e is ValueException &&
                e.message == 'Invalid value. User id must not be empty.',
          ),
        ),
      );
    });

    test('when name is empty string exception is thrown', () {
      expect(
            () => UserTester(UserId('uid'), UserName('')),
        throwsA(
          predicate(
                (e) =>
            e is ValueException &&
                e.message == 'Invalid value. User name must not be empty.',
          ),
        ),
      );
    });
  });

  group('toString', () {
    test('from object', () {
      expect(
        UserTester(UserId('uid'), UserName('jack')).toString(),
        equals('UserTester(UserId(uid), UserName(jack))'),
      );
    });
  });

  group('json', () {
    test('all types from json', () {
      final givenDependentJson = '''{
        "runtimeType": "Dependent",
        "id": "uid",
        "userName": "jack"
      }''';

      final dependent = Dependent.fromJson(givenDependentJson);

      expect(dependent, isA<Dependent>());
      expect(dependent.id, equals('uid'));
      expect(dependent.name, equals('jack'));

      final givenCareGiverJson = '''{
        "runtimeType": "CareGiver",
        "id": "uid",
        "userName": "jack"
      }''';
      final careGiver = CareGiver.fromJson(givenCareGiverJson);

      expect(careGiver, isA<CareGiver>());
      expect(careGiver.id, equals('uid'));
      expect(careGiver.name, equals('jack'));

      final givenCareProviderJson = '''{
        "runtimeType": "CareProvider",
        "id": "uid",
        "userName": "jack"
      }''';
      final careProvider = CareProvider.fromJson(givenCareProviderJson);

      expect(careProvider, isA<CareProvider>());
      expect(careProvider.id, equals('uid'));
      expect(careProvider.name, equals('jack'));
    });

    test('all types to json', () {
      final Json expectedDependentJson = {
        "runtimeType": "Dependent",
        "id": "uid",
        "userName": "jack"
      };
      final Json expectedCareGiverJson = {
        "runtimeType": "CareGiver",
        "id": "uid",
        "userName": "jack"
      };
      final Json expectedCareProviderJson = {
        "runtimeType": "CareProvider",
        "id": "uid",
        "userName": "jack"
      };

      expect(
        Dependent(UserId('uid'), UserName('jack')).toJson(),
        equals(expectedDependentJson),
      );
      expect(
        CareGiver(UserId('uid'), UserName('jack')).toJson(),
        equals(expectedCareGiverJson),
      );
      expect(
        CareProvider(UserId('uid'), UserName('jack')).toJson(),
        equals(expectedCareProviderJson),
      );
    });
  });
}