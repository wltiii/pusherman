import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:pusherman/core/error/failure.dart';

import 'package:pusherman/core/presentation/converter/input_converter.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';
import 'package:pusherman/features/schedule/domain/usecases/get_pill_box_set.dart';
import 'package:pusherman/features/schedule/presentation/blocs/pillboxset/bloc.dart';

import 'get_pill_box_set_event.dart';

const String DEPENDENT_NOT_FOUND = "Could not find a pill box set for the dependent.";
const String DEPENDENT_INVALID = "Dependent was not entered or invalid.";
const String UNAVAILABLE_NETWORK = "Network is unavailable.";

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
  Stream<PillBoxSetState> mapEventToState(PillBoxSetEvent event) async* {
    if(event is GetPillBoxSetForDependentEvent) {
      final inputEither = inputConverter.toWordString(event.dependent);

      yield* inputEither.fold(
        (failure) async* {
          yield PillBoxSetError(message: DEPENDENT_INVALID);
        },
        (dependent) async* {
          // yield* _loadOrError(dependent);
          yield PillBoxSetLoading();
          final failureOrPillBoxSet = await getPillBoxSet(Params(dependent: dependent));
          yield* _loadOrError(failureOrPillBoxSet);
        },
      );
    }
    else if (event is PillBoxSetupEvent) {
      yield PillBoxSetSetup();
    }
    else if (event is PillBoxSetupDone) {
      yield PillBoxSetSetupDone();
    }
  }

  Stream<PillBoxSetState> _loadOrError(Either<Failure, PillBoxSet> failureOrPillBoxSet) async* {
    // yield PillBoxSetLoading();
    // final failureOrPillBoxSet = await getPillBoxSet(Params(dependent: dependent));
    yield failureOrPillBoxSet.fold(
        (failure) => PillBoxSetError(message: _buildPillBoxSetError(failure)),
        (pillBoxSet) => PillBoxSetLoaded(pillBoxSet: pillBoxSet),
    );
  }

  String _buildPillBoxSetError(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return UNAVAILABLE_NETWORK;
      case CacheFailure:
        return DEPENDENT_NOT_FOUND;
        //TODO default is untested - use freezed instead!
      default:
        return 'Unexpected Error';
    }
  }
}