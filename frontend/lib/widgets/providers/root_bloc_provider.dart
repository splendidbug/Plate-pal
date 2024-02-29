import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/blocs/recpie/recpie_bloc.dart';
import 'package:frontend/blocs/recpie/recpie_event.dart';
import 'package:frontend/di/di.dart';
import 'package:frontend/infrastructure/infrastructure.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootBlocProvider extends StatelessWidget {
  final Widget child;

  const RootBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DI.get<NavigationBloc>(),
        ),
        BlocProvider(
          create: (context) {
            final bloc = DI.get<NotificationBloc>();

            // Notifications on HTTP errors
            DI.get<ErrorInterceptor>().errors.stream.listen((error) {
              bloc.add(NotificationEvent.show(
                type: NotificationType.ERROR,
                message: 'Oh No! PlatePal ${error.response?.statusCode}',
              ));
            });

            return bloc;
          },
        ),
        BlocProvider(
          create: (context) => DI.get<UserBloc>()..add(const UserEvent.initial()),
        ),
        // BlocProvider(
        //   create: (context) => DI.get<FriendBloc>(),
        // ),
        BlocProvider(
          create: (context) => DI.get<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => DI.get<ChatBloc>(),
        ),
        BlocProvider(
          create: (context) => DI.get<PrefrencesBloc>(),
        ),
        BlocProvider(
          create: (context) => DI.get<InventoryBloc>(),
        ),
        BlocProvider(
          create: (context) => DI.get<RecpieBloc>()..add(const RELoad()),
        ),
      ],
      child: RootBlocListener(
        child: child,
      ),
    );
  }
}
