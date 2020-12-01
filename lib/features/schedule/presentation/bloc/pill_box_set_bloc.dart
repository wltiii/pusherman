import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../../../../core/error/failure.dart';

import '../../../../core/presentation/converter/input_converter.dart';
import '../../domain/usecases/get_pill_box_set.dart';
import './bloc.dart';

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
  Stream<PillBoxSetState> mapEventToState(
    PillBoxSetEvent event,
  ) async* {
    if(event is GetPillBoxSetForDependent) {
      final inputEither = inputConverter.toWordString(event.dependent);

      yield* inputEither.fold(
        (failure) async* {
          yield PillBoxSetError(message: DEPENDENT_INVALID);
        },
        (dependent) async* {
          yield* _loadOrError(dependent);
        },
      );
    }
  }

  Stream<PillBoxSetState> _loadOrError(String dependent) async* {
    yield PillBoxSetLoading();
    final failureOrPillBoxSet = await getPillBoxSet(Params(dependent: dependent));
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
