import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:pusherman/features/schedule/domain/entities/pill.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_set.dart';
import 'package:pusherman/features/schedule/domain/repositories/treatment_repository.dart';
import 'package:pusherman/features/schedule/domain/usecases/get_organizer.dart';

class MockOrganizerRepository extends Mock implements TreatmentRepository {}

void main() {
  GetOrganizer useCase;
  MockOrganizerRepository mockOrganizerRepository;

  final Organizer = Organizer(dependent: 'Zorba', caretakers: [
    'Bill'
  ], pillBoxes: [
    PillBox(name: 'Morning', frequency: 'Daily', pills: [
      Pill(name: "Extra Virgin Olive Oil"),
    ])
  ]);

  setUp(() {
    mockOrganizerRepository = MockOrganizerRepository();
    useCase = GetOrganizer(mockOrganizerRepository);
  });

  test('gets pill box set from the repository', () async {
    // given
    String givenDependent = 'Zorba';
    when(mockOrganizerRepository.getByDependent(any))
        .thenAnswer((_) async => Right(Organizer));
    // when
    final result = await useCase(Params(dependent: givenDependent));
    // then
    expect(result, Right(Organizer));
    verify(mockOrganizerRepository.getByDependent(givenDependent));
    verifyNoMoreInteractions(mockOrganizerRepository);
  });
}
