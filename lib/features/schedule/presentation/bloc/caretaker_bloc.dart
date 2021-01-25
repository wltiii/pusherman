import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:pusherman/core/presentation/converter/input_converter.dart';
import 'package:pusherman/features/schedule/domain/usecases/get_caretaker.dart';
import 'package:pusherman/features/schedule/presentation/bloc/bloc.dart';

class CaretakerBloc extends Bloc<CaretakerEvent, CaretakerState> {
  final GetCaretaker getCaretaker;
  final InputConverter inputConverter;

  CaretakerBloc({
    @required GetCaretaker caretakerGetter,
    @required this.inputConverter,
  })  : assert(caretakerGetter != null),
        assert(inputConverter != null),
        getCaretaker = caretakerGetter;

  @override
  CaretakerState get initialState => CaretakerEmpty();

  @override
  Stream<CaretakerState> mapEventToState(
    CaretakerEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
