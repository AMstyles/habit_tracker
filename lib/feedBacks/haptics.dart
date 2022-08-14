import 'package:flutter/services.dart';

void onStartHaptic() {
  Future.delayed(const Duration(milliseconds: 180), () {
    HapticFeedback.lightImpact();
  });

  Future.delayed(const Duration(milliseconds: 500), () {
    HapticFeedback.selectionClick();
  });
}

void onpausetHaptic() {
  Future.delayed(const Duration(milliseconds: 180), () {
    HapticFeedback.selectionClick();
  });

  Future.delayed(const Duration(milliseconds: 500), () {
    HapticFeedback.lightImpact();
  });
}
