import 'package:equatable/equatable.dart';
import 'package:pusherman/features/schedule/domain/entities/pill.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_set.dart';
import 'package:test/test.dart';

void main() {
  final List<String> caretakers = ["Bill", "Pooh"];
  final pillBox = PillBox(name: 'Morning', frequency: 'Daily', pills: [
    Pill(name: "Extra Virgin Olive Oil"),
  ]);

  final Organizer = Organizer(
      dependent: 'Coda', caretakers: caretakers, pillBoxes: [pillBox]);

  group("construction", () {
    test('should be a subclass of Equatable entity', () async {
      expect(Organizer, isA<Equatable>());
    });

    test('instantiates a Organizer from named argument constructor', () {
      expect(Organizer.dependent, equals('Coda'));
      expect(Organizer.caretakers.length, equals(2));
      expect(Organizer.pillBoxes.length, equals(1));
    });
  });

  group("Equatable", () {
    test(
        'props contains list of all properties that determine equality when constructed',
        () {
      expect(
          Organizer.props,
          equals([
            Organizer.dependent,
            Organizer.caretakers,
            Organizer.pillBoxes
          ]));
    });

    test('stringify is turned on when constructed', () {
      expect(Organizer.stringify, isTrue);
    });
  });
}
