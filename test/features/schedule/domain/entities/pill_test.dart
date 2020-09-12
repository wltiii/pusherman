import 'package:equatable/equatable.dart';
import 'package:pusherman/features/schedule/domain/entities/pill.dart';
import 'package:test/test.dart';

void main() {
  final pill = Pill(name: "Zinc");

  group("construction", () {
    test('should be a subclass of Equatable entity', () async {
      expect(pill, isA<Equatable>());
    });

    test("instantiates a Pill from named argument constructor", () {
      expect(pill.name, equals('Zinc'));
    });
  });

  group("Equatable", () {
    test('props contains list of all properties that determine equality when constructed', ()
    {
      expect(pill.props, equals([pill.name]));
    });

    test('stringify is turned on when constructed', ()
    {
      expect(pill.stringify, isTrue);
    });
  });
}