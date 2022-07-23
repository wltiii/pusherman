import 'package:flutter/foundation.dart';
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

/*
class Dependent extends User {
  const Dependent(UserId id, UserName userName) : super(id, userName);

  factory Dependent.fromJson(id, userName) {
    return super.fromJson(id, userName)
  }

  Json super.toJson();
}


 */

void main() {
  group('construction', () {
    test('all User types constructed', () {
// Not Yet Implemented: user types defined by roles: Caregiver | Dependent | ???
      final user = UserTester(UserId('uid'), UserName('jack'));
      expect(user, isA<User>());
      expect(user, isA<Equatable>());
      expect(user.id, equals('uid'));
      expect(user.name, equals('jack'));
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
    test('Dependent from json', () {
      final givenJson = '''{
        "id": "uid",
        "userName": "jack"
      }''';

      final result = Dependent.fromJson(givenJson);

      expect(result, isA<Dependent>());
      expect(result.id, equals('uid'));
      expect(result.name, equals('jack'));
    });

    test('Dependent to json', () {
      expect(
        Dependent(UserId('uid'), UserName('jack')).toString(),
        equals('Dependent(UserId(uid), UserName(jack))'),
      );
    });
  });
}