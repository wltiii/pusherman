import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pusherman/features/schedule/domain/entities/pill.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';
import 'package:pusherman/features/schedule/domain/repositories/pill_box_set_repository.dart';
import 'package:pusherman/features/schedule/domain/usecases/get_pill_box_set.dart';

class MockPillBoxSetRepository extends Mock implements PillBoxSetRepository {}

void main() {
  GetPillBoxSet useCase;
  MockPillBoxSetRepository mockPillBoxSetRepository;

  final pillBoxSet = PillBoxSet(
      dependent: 'Zorba',
      caretakers: ['Bill'],
      pillBoxes: [
        PillBox(
            name: 'Morning',
            frequency: 'Daily',
            pills: [
              Pill(name: "Extra Virgin Olive Oil"),
            ]
        )
      ]
  );

  setUp(() {
    mockPillBoxSetRepository = MockPillBoxSetRepository();
    useCase = GetPillBoxSet(mockPillBoxSetRepository);
  });

  test('gets pill box set from the repository', () async {
    // given
    // TODO why doesn't setUp work? Shouldn't need the following two lines
    mockPillBoxSetRepository = MockPillBoxSetRepository();
    useCase = GetPillBoxSet(mockPillBoxSetRepository);

    var givenDependent = 'Zorba';
    when(mockPillBoxSetRepository.getByDependent(givenDependent))
        .thenAnswer((_) async => Right(pillBoxSet));
    // when
    final result = await useCase(Params(dependent: givenDependent));
    // then
    expect(result, Right(pillBoxSet));
    verify(mockPillBoxSetRepository.getByDependent(givenDependent));
    verifyNoMoreInteractions(mockPillBoxSetRepository);
  });
}