import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sealed_unions/sealed_unions.dart';

import '../../domain/entities/pill_box_set.dart';

class PillBoxSetState extends Union4Impl<
    _PillBoxSetEmpty,
    _PillBoxSetLoading,
    _PillBoxSetLoaded,
    _PillBoxSetError> {
  static final Quartet<
    _PillBoxSetEmpty,
    _PillBoxSetLoading,
    _PillBoxSetLoaded,
    _PillBoxSetError> _factory = const Quartet<
      _PillBoxSetEmpty,
      _PillBoxSetLoading,
      _PillBoxSetLoaded,
      _PillBoxSetError>();

  PillBoxSetState._(
      Union4<
          _PillBoxSetEmpty,
          _PillBoxSetLoading,
          _PillBoxSetLoaded,
          _PillBoxSetError> union,
      ) : super(union);

  factory PillBoxSetState.empty() =>
      PillBoxSetState._(_factory.first(_PillBoxSetEmpty()));

  factory PillBoxSetState.loading() =>
      PillBoxSetState._(_factory.second(_PillBoxSetLoading()));

  factory PillBoxSetState.loaded(PillBoxSet pillBoxSet) =>
      PillBoxSetState._(_factory.third(_PillBoxSetLoaded(pillBoxSet: pillBoxSet)));

  factory PillBoxSetState.error(String message) =>
      PillBoxSetState._(_factory.fourth(_PillBoxSetError(message: message)));
}

class _PillBoxSetEmpty extends Equatable {
  @override
  List<Object> get props => [];
}

class _PillBoxSetLoading extends Equatable {
  @override
  List<Object> get props => [];
}

class _PillBoxSetLoaded extends Equatable {
  final PillBoxSet pillBoxSet;

  _PillBoxSetLoaded({@required this.pillBoxSet});

  @override
  List<Object> get props => [pillBoxSet];
}
class _PillBoxSetError extends Equatable {
  final String message;

  _PillBoxSetError({@required this.message});

  @override
  List<Object> get props => [message];
}
