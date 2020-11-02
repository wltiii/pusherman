import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pusherman/core/presentation/converter/input_converter.dart';
import 'package:pusherman/features/schedule/domain/usecases/get_pill_box_set.dart';
import 'package:pusherman/features/schedule/presentation/bloc/pill_box_set_bloc.dart';
import 'package:pusherman/features/schedule/presentation/bloc/pill_box_set_state.dart';

class MockGetPillBoxSet extends Mock implements GetPillBoxSet {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  PillBoxSetBloc bloc;
  MockGetPillBoxSet mockGetPillBoxSet;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetPillBoxSet = MockGetPillBoxSet();
    mockInputConverter = MockInputConverter();

    bloc = PillBoxSetBloc(
      pillBoxSetGetter: mockGetPillBoxSet,
      inputConverter: mockInputConverter,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(PillBoxSetEmpty()));
  });


}