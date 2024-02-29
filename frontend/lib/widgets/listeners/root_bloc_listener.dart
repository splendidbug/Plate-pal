import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/di/di.dart';
import 'package:frontend/models/models.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class RootBlocListener extends StatelessWidget {
  final Widget child;

  const RootBlocListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Listners are required for service blocs also to work
    // Just like the case with observables (probably cuz internally streams are used)
    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationBloc, NotificationState>(
          listener: _notificationHandler,
        ),
        BlocListener<UserBloc, UserState>(
          listener: _userHandler,
        ),
      ],
      child: child,
    );
  }

  void _notificationHandler(BuildContext context, NotificationState state) {
    switch (state.type) {
      case NotificationType.WARN:
        DI.logger().w(state.message);
        break;
      case NotificationType.ERROR:
        DI.logger().e(state.message);
        break;
      default:
        DI.logger().i(state.message);
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: state.type.backgroundColor,
        content: Text(
          state.message,
          style: TextStyle(color: state.type.textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _userHandler(BuildContext context, UserState state) {
    DI.logger().i("User Event : $state");
  }
}
