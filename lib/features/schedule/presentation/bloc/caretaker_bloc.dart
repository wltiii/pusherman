import 'dart:async';

import 'package:bloc/bloc.dart';
import './bloc.dart';

class CaretakerBloc extends Bloc<CaretakerEvent, CaretakerState> {
  CaretakerBloc() : super(CaretakerInitial());

  @override
  Stream<CaretakerState> mapEventToState(
    CaretakerEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
