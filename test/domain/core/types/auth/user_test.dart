import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/models/types/auth/user.dart';
import 'package:pusherman/domain/core/models/types/type_defs.dart';
import 'package:unrepresentable_state/unrepresentable_state.dart';

import '../../../../test_utils/user_builder.dart';

class UserTester extends User {
  const UserTester(Id id, DependentName name) : super(id, name);

// Json toJson() {
//   return super.toJson();
// }
}

void main() {
  group('construction', () {
    test('abstract User', () {
      final tester = UserTester(Id('uid'), DependentName('jack'));
      expect(tester, isA<User>());
      expect(tester, isA<Equatable>());
      expect(tester.id, equals('uid'));
      expect(tester.name, equals('jack'));
    });

    test('implemented User types constructed', () {
      final dependent = Dependent(
        DependentId(UserBuilder.DEFAULT_ID),
        DependentName(UserBuilder.DEFAULT_NAME),
      );
      // expect(dependent, isA<Equatable>());
      expect(dependent, isA<User>());
      expect(dependent.id, equals(UserBuilder.DEFAULT_ID));
      expect(dependent.name, equals(UserBuilder.DEFAULT_NAME));

      final careGiver = CareGiver(
        CareGiverId(UserBuilder.DEFAULT_ID),
        CareGiverName(UserBuilder.DEFAULT_NAME),
      );
      expect(careGiver.id, equals(UserBuilder.DEFAULT_ID));
      expect(careGiver.name, equals(UserBuilder.DEFAULT_NAME));

      final careProvider = CareProvider(
        CareProviderId(UserBuilder.DEFAULT_ID),
        CareProviderName(UserBuilder.DEFAULT_NAME),
      );
      expect(careProvider.id, equals(UserBuilder.DEFAULT_ID));
      expect(
          careProvider.name,
          equals(
            DependentName(UserBuilder.DEFAULT_NAME).value,
          ));
    });
  });

  group('toString', () {
    test('from CareGiver', () {
      final careGiver = CareGiver(
        CareGiverId(UserBuilder.DEFAULT_ID),
        CareGiverName(UserBuilder.DEFAULT_NAME),
      );
      expect(
        careGiver.toString(),
        equals(
            'CareGiver(CareGiverId(${UserBuilder.DEFAULT_ID}), CareGiverName(${UserBuilder.DEFAULT_NAME}))'),
      );
    });
  });

  group('json', () {
    test('implemented User types from json', () {
      // final givenDependentJson = '''{
      //   "runtimeType": "Dependent",
      //   "id": "uid",
      //   "userName": "jack"
      // }''';

      final givenDependentJson = {"runtimeType": "Dependent", "id": "uid", "userName": "jack"};

      final dependent = Dependent.fromJson(givenDependentJson);

      expect(dependent, isA<Dependent>());
      expect(dependent.id, equals('uid'));
      expect(dependent.name, equals('jack'));

      // final givenCareGiverJson = '''{
      //   "runtimeType": "CareGiver",
      //   "id": "uid",
      //   "userName": "jack"
      // }''';

      final givenCareGiverJson = {"runtimeType": "CareGiver", "id": "uid", "userName": "jack"};
      final careGiver = CareGiver.fromJson(givenCareGiverJson);

      expect(careGiver, isA<CareGiver>());
      expect(careGiver.id, equals('uid'));
      expect(careGiver.name, equals('jack'));

      // final givenCareProviderJson = '''{
      //   "runtimeType": "CareProvider",
      //   "id": "uid",
      //   "userName": "jack"
      // }''';

      final givenCareProviderJson = {
        "runtimeType": "CareProvider",
        "id": "uid",
        "userName": "jack"
      };
      final careProvider = CareProvider.fromJson(givenCareProviderJson);

      expect(careProvider, isA<CareProvider>());
      expect(careProvider.id, equals('uid'));
      expect(careProvider.name, equals('jack'));
    });

    test('abstract User to json', () {});

    test('implemented User types to json', () {
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
        Dependent(DependentId('uid'), DependentName('jack')).toJson(),
        equals(expectedDependentJson),
      );
      expect(
        CareGiver(CareGiverId('uid'), CareGiverName('jack')).toJson(),
        equals(expectedCareGiverJson),
      );
      expect(
        CareProvider(CareProviderId('uid'), CareProviderName('jack')).toJson(),
        equals(expectedCareProviderJson),
      );
    });
  });

  group('user domain sub types', () {
    test('CareGiverId is an Id', () {
      expect(CareGiverId(UserBuilder.DEFAULT_ID), isA<Id>());
    });

    test('UserName is a Name', () {
      expect(DependentName(UserBuilder.DEFAULT_NAME), isA<Name>());
    });
  });
}
