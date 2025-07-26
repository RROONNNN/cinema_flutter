import 'package:flutter/material.dart';

enum SeatType { NORMAL, VIP, COUPLE, EMPTY }

extension SeatTypeExtension on SeatType {
  static SeatType fromString(String value) {
    try {
      return SeatType.values.firstWhere(
        (e) => e.name.toLowerCase() == value.toLowerCase(),
      );
    } catch (e) {
      debugPrint('Invalid seat type: $value');
      throw Exception('Invalid seat type: $value');
    }
  }
}
