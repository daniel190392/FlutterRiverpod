import 'package:flutter/material.dart';

enum ColorState {
  error,
  success,
  warning,
}

extension ColorStateExtension on ColorState {
  Color get colorValue {
    switch (this) {
      case ColorState.success:
        return Colors.green;
      case ColorState.error:
        return Colors.red;
      case ColorState.warning:
        return Colors.yellow;
    }
  }
}
