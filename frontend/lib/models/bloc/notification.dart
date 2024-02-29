import 'package:flutter/material.dart';

enum NotificationType {
  DEFAULT,
  INFO,
  SUCCESS,
  WARN,
  ERROR,
}

extension NotificationTypeExtension on NotificationType {
  Color? get backgroundColor {
    switch (this) {
      case NotificationType.SUCCESS:
        return Colors.green.shade700;
      case NotificationType.WARN:
        return Colors.yellow.shade700;
      case NotificationType.ERROR:
        return Colors.red.shade700;
      default:
        return null;
    }
  }

  Color? get textColor {
    switch (this) {
      case NotificationType.SUCCESS:
        return Colors.white;
      case NotificationType.WARN:
        return Colors.black;
      case NotificationType.ERROR:
        return Colors.white;
      default:
        return null;
    }
  }
}
