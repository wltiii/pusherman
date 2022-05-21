import 'package:equatable/equatable.dart';
import 'package:pusherman/features/schedule/domain/entities/caretaker.dart';
import 'package:test/test.dart';

void main() {
  final caretaker = Caregiver(name: 'Mick', dependents: [
    'John',
    'Paul',
    'George',
    'Ringo',
  ]);

  group("construction", () {
    test('should be a subclass of Equatable entity', () async {
      expect(caretaker, isA<Equatable>());
    });

    test('instantiates a Caretaker from named argument constructor', () {
      expect(caretaker.name, equals('Mick'));
      expect(caretaker.dependents.length, equals(4));
    });
  });

  group("Equatable", () {
    test(
        'props contains list of all properties that determine equality when constructed',
        () {
      expect(caretaker.props, equals([caretaker.name, caretaker.dependents]));
    });

    test('stringify is turned on when constructed', () {
      expect(caretaker.stringify, isTrue);
    });
  });
}
