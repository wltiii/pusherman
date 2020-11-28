import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';
import 'package:pusherman/features/schedule/presentation/bloc/pill_box_set_state.dart';

void main() {
  final pillBoxState = PillBoxSetState();
  final emptyState = PillBoxSetEmpty();
  final loadingState = PillBoxSetLoading();
  final loadedState = PillBoxSetLoaded(pillBoxSet: PillBoxSet(caretakers: [], dependent: 'aDependent', pillBoxes: []));
  final errorState = PillBoxSetError(message: 'anError');

  group("Equatable", () {
    test('should be a subclass of Equatable entity', () async {
      expect(pillBoxState, isA<Equatable>());
      expect(emptyState, isA<Equatable>());
      expect(loadingState, isA<Equatable>());
      expect(loadedState, isA<Equatable>());
      expect(errorState, isA<Equatable>());
    });

    test('contains correct number of props', () {
      expect(pillBoxState.props.length, equals(0));
      expect(emptyState.props.length, equals(0));
      expect(loadingState.props.length, equals(0));
      expect(loadedState.props.length, equals(1));
      expect(errorState.props.length, equals(1));
    });

    test('contains loaded state props of [PillBoxSet]', () {
      expect(loadedState.props, equals([
        PillBoxSet(
            caretakers: [],
            dependent: 'aDependent',
            pillBoxes: [],
        )
      ]));
    });

    test('contains error state props of [someString]', () {
      expect(errorState.props, equals([
        'anError',
      ]));
    });
  });

  group("Implementations", () {
    group("PillBoxSetEmpty", () {
      test('should be a subclass of PillBoxSetState', () async {
        expect(emptyState, isA<PillBoxSetState>());
      });
    });

    group("PillBoxSetLoading", () {
      test('should be a subclass of PillBoxSetState', () async {
        expect(loadingState, isA<PillBoxSetState>());
      });
    });

    group("PillBoxSetLoaded", () {
      test('should be a subclass of PillBoxSetState', () async {
        expect(loadedState, isA<PillBoxSetState>());
      });
    });

    group("PillBoxSetError", () {
      test('should be a subclass of PillBoxSetState', () async {
        expect(errorState, isA<PillBoxSetState>());
      });
    });

  });
}