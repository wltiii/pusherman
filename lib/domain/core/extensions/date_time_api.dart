import 'package:flutter/material.dart';

extension DateRange on DateTime {
  /// Validates that this DateTime instance is within the range, inclusive.
  /// Returns [bool] true when it is within the range, false otherwise.
  bool inRange(DateTimeRange range) {
    return range.start.compareTo(this) <= 0 && range.end.compareTo(this) >= 0;
  }
}
