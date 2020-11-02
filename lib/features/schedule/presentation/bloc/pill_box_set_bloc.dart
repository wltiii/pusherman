import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/presentation/converter/input_converter.dart';
import '../../domain/usecases/get_pill_box_set.dart';
import './bloc.dart';

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
    // TODO: implement mapEventToState
  }
}
