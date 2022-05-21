import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/types/auth/user.dart';

class AbstractUserTester extends User {
  const AbstractUserTester(
    UserId id,
    UserName name,
  ) : super(
          id,
          name,
        );
}

void main() {
  group('construction', () {
    test('all User types constructed', () {
// Not Yet Implemented: user types defined by roles: Caregiver | Dependent | ???
      final user = AbstractUserTester(UserId('uid'), UserName('jack'));
      expect(user, isA<User>());
      expect(user, isA<Equatable>());
      expect(user.id, equals('uid'));
      expect(user.name, equals('jack'));
    });

    test('when id is empty string exception is thrown', () {
      expect(
        () => AbstractUserTester(UserId(''), UserName('jack')),
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
        () => AbstractUserTester(UserId('uid'), UserName('')),
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
        AbstractUserTester(UserId('uid'), UserName('jack')).toString(),
        equals('AbstractUserTester(UserId(uid), UserName(jack))'),
      );
    });
  });
}
