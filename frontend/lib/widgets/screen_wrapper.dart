
import 'package:flutter/material.dart';

import 'listeners/screen_bloc_listner.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget child;

  const ScreenWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenBlocListner(child: child);
  }
}
