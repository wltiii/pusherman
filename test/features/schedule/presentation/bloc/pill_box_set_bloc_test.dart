import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:pusherman/core/presentation/converter/input_converter.dart';
import 'package:pusherman/features/schedule/domain/usecases/get_organizer.dart';
import 'package:pusherman/features/schedule/presentation/bloc/bloc.dart';

class MockGetOrganizer extends Mock implements GetOrganizer {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  OrganizerBloc bloc;
  MockGetOrganizer mockGetOrganizer;
  InputConverter inputConverter;

  setUp(() {
    mockGetOrganizer = MockGetOrganizer();
    inputConverter = InputConverter();

    bloc = OrganizerBloc(
      OrganizerGetter: mockGetOrganizer,
      inputConverter: inputConverter,
    );
  });

  test('initialState returns empty state', () {
    // assert
    expect(bloc.initialState, equals(OrganizerEmpty()));
  });

  group('GET Organizer', () {
    final givenDependent = 'bill';
    final expectedDependent = 'bill';
    final Organizer = Organizer(
        dependent: 'Coda', caretakers: caretakers, pillBoxes: [pillBox]);

    // TODO this test should be only necessary initially and
    // TODO removed once other logic/tests can do this as course of action
    test(
      'calls InputConverter to validate and convert the dependent',
      () async {
        // given
        final mockInputConverter = MockInputConverter();

        when(mockInputConverter.toWordString(any))
            .thenReturn(Right(expectedDependent));

        bloc = OrganizerBloc(
          OrganizerGetter: mockGetOrganizer,
          inputConverter: mockInputConverter,
        );

        // when
        bloc.add(GetOrganizerForDependent(givenDependent));
        await untilCalled(mockInputConverter.toWordString(any));

        // then
        verify(mockInputConverter.toWordString(expectedDependent));
      },
    );

    test('emits [error] states when dependent is invalid', () async {
      // given
      final expectedEmissions = [
        OrganizerEmpty(),
        OrganizerError(message: DEPENDENT_NOT_ENTERED)
      ];

      // expect
      expectLater(bloc, emitsInOrder(expectedEmissions));

      // when
      bloc.add(GetOrganizerForDependent(null));
    });

    test('gets a pill box set', () async {
      // given
      when(mockGetOrganizer(givenDependent)).thenAnswer((_) async => Right());

      // when

      // then
    });
  });
}
