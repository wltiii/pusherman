import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/presentation/converter/input_converter.dart';
import '../../domain/usecases/get_pill_box_set.dart';
import './bloc.dart';

const String DEPENDENT_NOT_FOUND = "Could not find a pill box set for the dependent.";
const String DEPENDENT_NOT_ENTERED = "Dependent was not entered or invalid.";

class PillBoxSetBloc extends Bloc<PillBoxSetEvent, PillBoxSetState> {
  final GetPillBoxSet getPillBoxSet;
  final InputConverter inputConverter;

  PillBoxSetBloc({
    @required GetPillBoxSet pillBoxSetGetter,
    @required this.inputConverter,
  })  : assert(pillBoxSetGetter != null),
        assert(inputConverter != null),
        getPillBoxSet = pillBoxSetGetter;

  @override
  PillBoxSetState get initialState => PillBoxSetEmpty();

  @override
  Stream<PillBoxSetState> mapEventToState(
    PillBoxSetEvent event,
  ) async* {
    if(event is GetPillBoxSetForDependent) {
      final inputEither = inputConverter.toWordString(event.dependent);

      yield* inputEither.fold(
        (failure) async* {
          yield PillBoxSetError(message: DEPENDENT_NOT_ENTERED);
        },
        (string) async* {
          // TODO: implement mapEventToState
          print("add logic here!");
          // yield Loading();
          // final failureOrTrivia =
          // await getPillBoxSet(Params(number: integer));
          // yield* _eitherLoadedOrErrorState(failureOrTrivia);
        },
      );
    }
  }
}
