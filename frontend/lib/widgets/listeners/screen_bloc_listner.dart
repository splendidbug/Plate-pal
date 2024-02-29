import 'package:frontend/di/di.dart';
import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/models/models.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenBlocListner extends StatelessWidget {
  final Widget child;

  const ScreenBlocListner({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<NavigationBloc, NavigationState>(
          listenWhen: (previous, current) => previous.route != current.route,
          listener: _navigationHandler,
        ),
      ],
      child: WillPopScope(onWillPop: () => _popHandler(navigationBloc), child: child),
    );
  }

  // TODO: Need To Improve
  void _navigationHandler(BuildContext context, NavigationState state) {
    DI.logger().i("Navigation Event : $state");

    final navigator = Navigator.of(context);

    switch (state.type) {
      case NavigationType.POP:
        navigator.popUntil(((route) => route.isFirst));
        break;
      case NavigationType.PUSH:
        navigator.pushNamed('/${state.route}', arguments: state.args);
        break;
      case NavigationType.PUSH_EMPTY:
        navigator.pushNamedAndRemoveUntil('/${state.route}', (route) => false, arguments: state.args);
        break;
      default:
        break;
    }
  }

  Future<bool> _popHandler(NavigationBloc navigationBloc) async {
    navigationBloc.add(const NavigationEvent.navigateTo(type: NavigationType.POP_BACK));
    return true;
  }
}
