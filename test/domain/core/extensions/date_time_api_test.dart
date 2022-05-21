import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pusherman/domain/core/extensions/date_time_api.dart';

void main() {
  group('DateRange extension tests', () {
    group('inRange tests', () {
      test('inRange returns true when date is between start and end range', () {
        final start = DateTime.now();
        sleep(const Duration(milliseconds: 10));
        final between = DateTime.now();
        sleep(const Duration(milliseconds: 10));
        final end = DateTime.now();

        final range = DateTimeRange(start: start, end: end);

        expect(between.inRange(range), isTrue);
      });

      test('true when date equals start date', () {
        final start = DateTime.now();
        sleep(const Duration(milliseconds: 10));
        final end = DateTime.now();

        final between = DateTime(
          start.year,
          start.month,
          start.day,
          start.hour,
          start.minute,
          start.second,
          start.millisecond,
          start.microsecond,
        );

        final range = DateTimeRange(start: start, end: end);

        expect(between.inRange(range), isTrue);
      });

      test('true when date equals end date', () {
        final start = DateTime.now();
        sleep(const Duration(milliseconds: 10));
        final end = DateTime.now();

        final between = DateTime(
          end.year,
          end.month,
          end.day,
          end.hour,
          end.minute,
          end.second,
          end.millisecond,
          end.microsecond,
        );

        final range = DateTimeRange(start: start, end: end);

        expect(between.inRange(range), isTrue);
      });

      test('false when date is before range start', () {
        final before = DateTime.now();
        sleep(const Duration(milliseconds: 10));
        final start = DateTime.now();
        sleep(const Duration(milliseconds: 10));
        final end = DateTime.now();

        final range = DateTimeRange(start: start, end: end);

        expect(before.inRange(range), isFalse);
      });

      test('false when date is after range end', () {
        final start = DateTime.now();
        sleep(const Duration(milliseconds: 10));
        final end = DateTime.now();
        sleep(const Duration(milliseconds: 10));
        final after = DateTime.now();

        final range = DateTimeRange(start: start, end: end);

        expect(after.inRange(range), isFalse);
      });
    });
  });
}
