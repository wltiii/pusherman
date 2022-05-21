import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/extensions/string_api.dart';

void main() {
  group('capitalize tests', () {
    test('empty string returns empty string', () {
      const s = '';

      expect(s.capitalize().isEmpty, isTrue);
    });

    test('lowercase char returns uppercase case', () {
      const s = 'a';

      expect(s.capitalize(), equals('A'));
    });

    test('single word string returns capitalized', () {
      const s = 'apple';

      expect(s.capitalize(), equals('Apple'));
    });

    test('multi word string returns capitalized', () {
      const s = 'apples are good';

      expect(s.capitalize(), equals('Apples are good'));
    });

    test('strings starting with numbers are not capitalized', () {
      const s = '1 apple a day';

      expect(s.capitalize(), equals('1 apple a day'));
    });

    test('does not alter case of other words', () {
      const s = 'an Apple a day';

      expect(s.capitalize(), equals('An Apple a day'));
    });
  });

  group('title case tests', () {
    test('empty string returns empty string', () {
      const s = '';

      expect(s.toTitleCase().isEmpty, isTrue);
    });

    test('lowercase char returns uppercase case', () {
      const s = 'a';

      expect(s.toTitleCase(), equals('A'));
    });

    test('single word string returns capitalized', () {
      const s = 'apple';

      expect(s.toTitleCase(), equals('Apple'));
    });

    test('multi word string returns title cased', () {
      const s = 'apples are good';

      expect(s.toTitleCase(), equals('Apples Are Good'));
    });

    test('strings starting with numbers are title cased', () {
      const s = '1 apple a day';

      expect(s.toTitleCase(), equals('1 Apple A Day'));
    });
  });
}
