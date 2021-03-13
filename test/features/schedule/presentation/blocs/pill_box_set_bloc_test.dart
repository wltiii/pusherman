import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pusherman/core/error/failure.dart';
import 'package:pusherman/core/presentation/converter/input_converter.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';
import 'package:pusherman/features/schedule/domain/usecases/get_pill_box_set.dart';
import 'package:pusherman/features/schedule/presentation/blocs/pillboxset/bloc.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'pill_box_set_bloc_test.mocks.dart';

@GenerateMocks([GetPillBoxSet])

void main() {
  var mockGetPillBoxSet = MockGetPillBoxSet();
  InputConverter inputConverter;
  PillBoxSetBloc bloc = PillBoxSetBloc(
    getPillBoxSet: mockGetPillBoxSet,
    inputConverter: InputConverter(),
  );

  test('create returns initialState state', () {
    // given
    mockGetPillBoxSet = MockGetPillBoxSet();
    inputConverter = InputConverter();

    bloc = PillBoxSetBloc(
      getPillBoxSet: mockGetPillBoxSet,
      inputConverter: inputConverter,
    );

    // assert
    expect(bloc.initialState, equals(PillBoxSetInitialState()));
  });

  group('GET PillBoxSet', () {
    final pillBoxSetMap = fixtureAsMap('coda_pill_box_set.json');
    final givenDependent = pillBoxSetMap['dependent'];
    final PillBoxSet expectedPillBoxSet = PillBoxSetModel.fromJson(pillBoxSetMap);

    test('emits [error] states when dependent is invalid', () async {
      // given
      // TODO why is this being initialized in every test?
      mockGetPillBoxSet = MockGetPillBoxSet();
      inputConverter = InputConverter();

      bloc = PillBoxSetBloc(
        getPillBoxSet: mockGetPillBoxSet,
        inputConverter: inputConverter,
      );

      final expectedEmissions = [
        PillBoxSetError(message: DEPENDENT_INVALID)
      ];

      // expect
      expectLater(bloc, emitsInOrder(expectedEmissions));

      // when
      bloc.add(GetPillBoxSetForDependentEvent(null));
    });

    test('gets a pill box set', () async {
      // given
      mockGetPillBoxSet = MockGetPillBoxSet();
      inputConverter = InputConverter();

      bloc = PillBoxSetBloc(
        getPillBoxSet: mockGetPillBoxSet,
        inputConverter: inputConverter,
      );

      when(mockGetPillBoxSet(any))
          .thenAnswer((_) async => Right(expectedPillBoxSet));

      // when
      bloc.add(GetPillBoxSetForDependentEvent(givenDependent));
      await untilCalled(mockGetPillBoxSet(any));

      // then
      verify(mockGetPillBoxSet(Params(dependent: givenDependent)));
    });

    test('emits [Loading, Loaded] when data is successfully retrieved', () async {
      // given
      mockGetPillBoxSet = MockGetPillBoxSet();
      inputConverter = InputConverter();

      bloc = PillBoxSetBloc(
        getPillBoxSet: mockGetPillBoxSet,
        inputConverter: inputConverter,
      );
      final expectedEmissions = [
        PillBoxSetLoading(),
        PillBoxSetLoaded(pillBoxSet: expectedPillBoxSet)
      ];
      when(mockGetPillBoxSet(any))
          .thenAnswer((_) async => Right(expectedPillBoxSet));

      // expect
      expectLater(bloc, emitsInOrder(expectedEmissions));

      // when
      bloc.add(GetPillBoxSetForDependentEvent(givenDependent));
      await untilCalled(mockGetPillBoxSet(any));

      // then
      verify(mockGetPillBoxSet(Params(dependent: givenDependent)));
    });

    test('emits [Loading, Error] when server retrieval fails', () async {
      // given
      mockGetPillBoxSet = MockGetPillBoxSet();
      inputConverter = InputConverter();

      bloc = PillBoxSetBloc(
        getPillBoxSet: mockGetPillBoxSet,
        inputConverter: inputConverter,
      );
      final expectedEmissions = [
        PillBoxSetLoading(),
        PillBoxSetError(message: UNAVAILABLE_NETWORK)
      ];
      when(mockGetPillBoxSet(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      // expect
      expectLater(bloc, emitsInOrder(expectedEmissions));

      // when
      bloc.add(GetPillBoxSetForDependentEvent(givenDependent));
      await untilCalled(mockGetPillBoxSet(any));

      // then
      verify(mockGetPillBoxSet(Params(dependent: givenDependent)));
    });

    test('emits [Loading, Error] when cache retrieval fails', () async {
      // given
      mockGetPillBoxSet = MockGetPillBoxSet();
      inputConverter = InputConverter();

      bloc = PillBoxSetBloc(
        getPillBoxSet: mockGetPillBoxSet,
        inputConverter: inputConverter,
      );
      final expectedEmissions = [
        PillBoxSetLoading(),
        PillBoxSetError(message: DEPENDENT_NOT_FOUND)
      ];
      when(mockGetPillBoxSet(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      // expect
      expectLater(bloc, emitsInOrder(expectedEmissions));

      // when
      bloc.add(GetPillBoxSetForDependentEvent(givenDependent));
      await untilCalled(mockGetPillBoxSet(any));

      // then
      verify(mockGetPillBoxSet(Params(dependent: givenDependent)));
    });
  });
}