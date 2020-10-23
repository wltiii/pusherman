import 'dart:async';

import 'package:bloc/bloc.dart';
import './bloc.dart';

class PillBoxSetBloc extends Bloc<PillBoxSetEvent, PillBoxSetState> {
  PillBoxSetBloc() : super(PillBoxSetInitial());

  @override
  Stream<PillBoxSetState> mapEventToState(
    PillBoxSetEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
