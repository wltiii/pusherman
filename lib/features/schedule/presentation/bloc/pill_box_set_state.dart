import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';

@immutable
abstract class PillBoxSetState extends Equatable {
  @override
  List<Object> get props => [];
}

class PillBoxSetEmpty extends PillBoxSetState {}

class PillBoxSetLoading extends PillBoxSetState {}

class PillBoxSetLoaded extends PillBoxSetState {
  final PillBoxSet pillBoxSet;

  PillBoxSetLoaded({ @required this.pillBoxSet });

  @override
  List<Object> get props => [pillBoxSet];
}
class PillBoxSetError extends PillBoxSetState {
  final String message;

  PillBoxSetError({ @required this.message });

  @override
  List<Object> get props => [message];
}
