import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/error/exceptions.dart';
import 'package:pusherman/domain/core/types/auth/password.dart';
import 'package:pusherman/domain/core/value_objects/non_empty_string.dart';

void main() {
  group('construction', () {
    test('constructs', () {
      const value = r'pAs$w0rd';
      final password = Password(value);
      expect(password, isA<NonEmptyString>());
      expect(password.value, equals(value));
    });

    test('when password is empty string exception is thrown', () {
      expect(
        () => Password(''),
        throwsA(
          predicate(
            (e) =>
                e is ValueException &&
                e.message ==
                    'Invalid value. '
                        'Password must be a minimum of six characters.',
          ),
        ),
      );
    });

    test('when less than six characters exception is thrown', () {
      const value = r'As0$';

      expect(
        () => Password(value),
        throwsA(
          predicate(
            (e) =>
                e is ValueException &&
                e.message ==
                    'Invalid value. '
                        'Password must be a minimum of six characters.',
          ),
        ),
      );
    });

    test('when does not contain uppercase exception is thrown', () {
      const value = r'pas$w0rd';

      expect(
        () => Password(value),
        throwsA(
          predicate(
            (e) =>
                e is ValueException &&
                e.message ==
                    'Invalid value. Password is invalid. '
                        'It must at lease one upper case letter, '
                        'one lower case letter and '
                        r'one of !$>_}.<"|+):/*+&^.',
          ),
        ),
      );
    });

    test('when does not contain lowercase exception is thrown', () {
      const value = r'PAS$W0RD';

      expect(
        () => Password(value),
        throwsA(
          predicate(
            (e) =>
                e is ValueException &&
                e.message ==
                    'Invalid value. Password is invalid. '
                        'It must at lease one upper case letter, '
                        'one lower case letter and '
                        r'one of !$>_}.<"|+):/*+&^.',
          ),
        ),
      );
    });

    test('when does not contain number exception is thrown', () {
      const value = r'pAs$word';

      expect(
        () => Password(value),
        throwsA(
          predicate(
            (e) =>
                e is ValueException &&
                e.message ==
                    'Invalid value. Password is invalid. '
                        'It must at lease one upper case letter, '
                        'one lower case letter and '
                        r'one of !$>_}.<"|+):/*+&^.',
          ),
        ),
      );
    });

    test('when does not contain special character exception is thrown', () {
      const value = 'pAssw0rd';

      expect(
        () => Password(value),
        throwsA(
          predicate(
            (e) =>
                e is ValueException &&
                e.message ==
                    'Invalid value. Password is invalid. '
                        'It must at lease one upper case letter, '
                        'one lower case letter and '
                        r'one of !$>_}.<"|+):/*+&^.',
          ),
        ),
      );
    });
  });
}
