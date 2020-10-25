import 'package:equatable/equatable.dart';
import 'package:pusherman/features/schedule/domain/entities/pill.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';
import 'package:test/test.dart';

void main() {

  final List<String> caretakers = ["Bill", "Pooh"];
  final pillBox = PillBox(
      name: 'Morning',
      frequency: 'Daily',
      pills: [
        Pill(name: "Extra Virgin Olive Oil"),
      ]
  );

  final pillBoxSet = PillBoxSet(
      dependent: 'Coda',
      caretakers: caretakers,
      pillBoxes: [pillBox]
  );


  group("construction", () {
    test('should be a subclass of Equatable entity', () async {
      expect(pillBoxSet, isA<Equatable>());
    });

    test('instantiates a PillBoxSet from named argument constructor', ()
    {
      expect(pillBoxSet.dependent, equals('Coda'));
      expect(pillBoxSet.caretakers.length, equals(2));
      expect(pillBoxSet.pillBoxes.length, equals(1));
    });

  });

  group("Equatable", () {
    test('props contains list of all properties that determine equality when constructed', ()
    {
      expect(pillBoxSet.props, equals([pillBoxSet.dependent, pillBoxSet.caretakers, pillBoxSet.pillBoxes]));
    });

    test('stringify is turned on when constructed', ()
    {
      expect(pillBoxSet.stringify, isTrue);
    });
  });
}