import 'package:flutter/material.dart';

enum BooperActionType { HAPPY, CAUTION, DANGER }

extension BooperActionTypeExtension on BooperActionType {
  Color? get backgroundColor {
    switch (this) {
      case BooperActionType.HAPPY:
        return Colors.green.shade700;
      case BooperActionType.CAUTION:
        return Colors.yellow.shade700;
      case BooperActionType.DANGER:
        return Colors.red.shade700;
      default:
        return null;
    }
  }

  Color? get textColor {
    switch (this) {
      case BooperActionType.HAPPY:
        return Colors.white;
      case BooperActionType.CAUTION:
        return Colors.black;
      case BooperActionType.DANGER:
        return Colors.white;
      default:
        return null;
    }
  }
}

class BooperAction {
  final String label;
  final BooperActionType type;
  final dynamic payload;

  const BooperAction({
    required this.label,
    required this.type,
    required this.payload,
  });
}
