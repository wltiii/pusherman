import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/models/value_objects/additional_info.dart';

void main() {
  group('construction', () {
    test('constructs with value', () {
      const value = 'My what a pretty face you have!';
      final additionalInfo = AdditionalInfo(value);
      expect(additionalInfo, isA<AdditionalInfo>());
      expect(additionalInfo.value, equals(value));
      expect(additionalInfo.toString(), equals('AdditionalInfo($value)'));
    });
  });
}
