import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pusherman/core/presentation/converter/input_converter.dart';
import 'package:pusherman/features/schedule/domain/usecases/get_pill_box_set.dart';
import 'package:pusherman/features/schedule/presentation/bloc/bloc.dart';

class MockGetPillBoxSet extends Mock implements GetPillBoxSet {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  PillBoxSetBloc bloc;
  MockGetPillBoxSet mockGetPillBoxSet;
  InputConverter inputConverter;

  setUp(() {
    mockGetPillBoxSet = MockGetPillBoxSet();
    inputConverter = InputConverter();

    bloc = PillBoxSetBloc(
      pillBoxSetGetter: mockGetPillBoxSet,
      inputConverter: inputConverter,
    );
  });

  test('initialState returns empty state', () {
    // assert
    expect(bloc.initialState, equals(PillBoxSetEmpty()));
  });

  group('GET PillBoxSet', () {
    final givenDependent = 'bill';
    final expectedDependent = 'bill';

    // TODO this test should be only necessary initially and
    // TODO removed once other logic/tests can do this as course of action
    test('calls InputConverter to validate and convert the dependent', () async {
        // given
        final mockInputConverter = MockInputConverter();

        when(mockInputConverter.toWordString(any))
            .thenReturn(Right(expectedDependent));

        bloc = PillBoxSetBloc(
          pillBoxSetGetter: mockGetPillBoxSet,
          inputConverter: mockInputConverter,
        );

        // when
        bloc.add(GetPillBoxSetForDependent(givenDependent));
        await untilCalled(mockInputConverter.toWordString(any));

        // then
        verify(mockInputConverter.toWordString(expectedDependent));
      },
    );

    test('emits [error] states when dependent is invalid', () async {
      // given
      final expectedEmissions = [
        PillBoxSetEmpty(),
        PillBoxSetError(message: DEPENDENT_NOT_ENTERED)
      ];

      // expect
      expectLater(bloc, emitsInOrder(expectedEmissions));

      // when
      bloc.add(GetPillBoxSetForDependent(null));
    });
  });
}