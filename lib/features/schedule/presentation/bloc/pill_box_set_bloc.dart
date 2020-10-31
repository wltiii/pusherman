import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../../core/presentation/converter/input_converter.dart';
import '../../domain/usecases/get_pill_box_set.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class PillBoxSetBloc extends Bloc<PillBoxSetEvent, PillBoxSetState> {
  final GetPillBoxSet getPillBoxSet;
  final InputConverter inputConverter;
  
  PillBoxSetBloc({
    @required GetPillBoxSet getSet,
    @required this.inputConverter,
  }) :
    assert(getSet != null),
    assert(inputConverter != null),
    getPillBoxSet = getSet;

  @override
  PillBoxSetState get initialState => Empty();

  @override
  Stream<PillBoxSetState> mapEventToState(
    PillBoxSetEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
