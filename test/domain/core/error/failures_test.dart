import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/error/failures.dart';
import 'package:pusherman/domain/core/value_objects/additional_info.dart';
import 'package:pusherman/domain/core/value_objects/exception_message.dart';

class AbstractFailureTester extends Failure {
  AbstractFailureTester(String defaultMessage, [AdditionalInfo? additionalInfo])
      : super(
          ExceptionMessage(defaultMessage),
          additionalInfo,
        );
}

class AbstractAuthenticationFailureTester extends AuthenticationFailure {
  AbstractAuthenticationFailureTester(
    String defaultMessage, [
    AdditionalInfo? additionalInfo,
  ]) : super(
          ExceptionMessage(defaultMessage),
          additionalInfo,
        );
}

void main() {
  group('abstractions', () {
    final additionalInfo = AdditionalInfo('Additional info text.');

    group('Failure abstraction', () {
      test('message and toString contain default message only', () {
        final result = AbstractFailureTester('Default Message text.');

        expect(result.message, equals('Default Message text.'));
        expect(result.toString(), equals('Default Message text.'));
      });

      test('message and toString contain default and additional info', () {
        final result =
            AbstractFailureTester('Default Message text.', additionalInfo);

        expect(
          result.message,
          equals('Default Message text. Additional info text.'),
        );
        expect(
          result.toString(),
          equals('Default Message text. Additional info text.'),
        );
      });
    });

    group('AuthenticationFailure abstraction', () {
      test('message and toString contain default message only', () {
        final result =
            AbstractAuthenticationFailureTester('Default Message text.');

        expect(
          result.message,
          equals(
            'Authentication failed. '
            'Default Message text.',
          ),
        );
        expect(
          result.toString(),
          equals(
            'Authentication failed. '
            'Default Message text.',
          ),
        );
      });
      test('message and toString contain default and additional info', () {
        final result = AbstractAuthenticationFailureTester(
          'Default Message text.',
          additionalInfo,
        );

        expect(
          result.message,
          equals(
            'Authentication failed. '
            'Default Message text. Additional info text.',
          ),
        );
        expect(
          result.toString(),
          equals(
            'Authentication failed. '
            'Default Message text. Additional info text.',
          ),
        );
      });
    });
  });

  group('concrete failure implementations', () {
    final additionalInfo = AdditionalInfo('Additional info text.');

    group('AuthenticationEmailInUseFailure', () {
      test('message and toString contain default message only', () {
        final result = AuthenticationEmailInUseFailure();

        expect(result, isA<AuthenticationFailure>());
        expect(result, isA<Failure>());
        expect(
          result.message,
          equals(
            'Authentication failed. '
            'An account already exists with that email.',
          ),
        );
        expect(
          result.toString(),
          equals(
            'Authentication failed. '
            'An account already exists with that email.',
          ),
        );
      });

      test('message and toString contain default and additional info', () {
        final result = AuthenticationEmailInUseFailure(additionalInfo);

        expect(
          result.message,
          equals(
            'Authentication failed. '
            'An account already exists with that email. '
            'Additional info text.',
          ),
        );
        expect(
          result.toString(),
          equals(
            'Authentication failed. '
            'An account already exists with that email. '
            'Additional info text.',
          ),
        );
      });
    });

    group('AuthenticationEmailInvalidFailure', () {
      test('message and toString contain default message only', () {
        final result = AuthenticationEmailInvalidFailure();

        expect(result, isA<AuthenticationEmailInvalidFailure>());
        expect(result, isA<Failure>());
        expect(result.message, equals('Email address is invalid.'));
        expect(result.toString(), equals('Email address is invalid.'));
      });

      test('message and toString contain default and additional info', () {
        final result = AuthenticationEmailInvalidFailure(additionalInfo);

        expect(
          result.message,
          equals('Email address is invalid. Additional info text.'),
        );
        expect(
          result.toString(),
          equals('Email address is invalid. Additional info text.'),
        );
      });
    });

    group('AuthenticationWeakPasswordFailure', () {
      test('message and toString contain default message only', () {
        final result = AuthenticationWeakPasswordFailure();

        expect(result, isA<AuthenticationWeakPasswordFailure>());
        expect(result, isA<Failure>());
        expect(result.message, equals('The password provided is too weak.'));
        expect(result.toString(), equals('The password provided is too weak.'));
      });

      test('message and toString contain default and additional info', () {
        final result = AuthenticationWeakPasswordFailure(additionalInfo);

        expect(
          result.message,
          equals('The password provided is too weak. Additional info text.'),
        );
        expect(
          result.toString(),
          equals('The password provided is too weak. Additional info text.'),
        );
      });
    });

    group('CacheFailure', () {
      test('message and toString contain default message only', () {
        final result = CacheFailure();

        expect(result, isA<CacheFailure>());
        expect(result, isA<Failure>());
        expect(result.message, equals('Cache failure.'));
        expect(result.toString(), equals('Cache failure.'));
      });

      test('message and toString contain default and additional info', () {
        final result = CacheFailure(additionalInfo);

        expect(result.message, equals('Cache failure. Additional info text.'));
        expect(
          result.toString(),
          equals('Cache failure. Additional info text.'),
        );
      });
    });

    group('NotFoundFailure', () {
      test('message and toString contain default message only', () {
        final result = NotFoundFailure();

        expect(result, isA<NotFoundFailure>());
        expect(result, isA<Failure>());
        expect(result.message, equals('Not found.'));
        expect(result.toString(), equals('Not found.'));
      });

      test('message and toString contain default and additional info', () {
        final result = NotFoundFailure(additionalInfo);

        expect(result.message, equals('Not found. Additional info text.'));
        expect(result.toString(), equals('Not found. Additional info text.'));
      });
    });
  });
}
