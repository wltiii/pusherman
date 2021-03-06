import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:pusherman/core/presentation/converter/input_converter.dart';
import 'package:pusherman/features/schedule/domain/usecases/get_caretaker.dart';
import 'package:pusherman/features/schedule/presentation/blocs/caretaker/bloc.dart';

class CaretakerBloc extends Bloc<CaretakerEvent, CaretakerState> {
  GetCaretaker getCaretaker;
  final InputConverter inputConverter;

  CaretakerBloc({
    @required GetCaretaker caretakerGetter,
    @required this.inputConverter,
  })  : super(CaretakerInitialState()) {
    getCaretaker = caretakerGetter;
  }

  @override
  CaretakerState get initialState => CaretakerInitialState();

  @override
  Stream<CaretakerState> mapEventToState(
    CaretakerEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}