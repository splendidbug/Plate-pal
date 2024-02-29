import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationBloc = BlocProvider.of<NotificationBloc>(context);
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) => SizedBox(
            height: 50,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("assets/images/codeblaze.png"),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    state.name,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     Clipboard.setData(ClipboardData(text: state.uid));
                //     notificationBloc.add(const NotificationEvent.show(
                //       type: NotificationType.INFO,
                //       message: "User ID Copied",
                //     ));
                //   },
                //   icon: const Icon(
                //     Icons.copy,
                //     color: Colors.grey,
                //   ),
                // ),
                // IconButton(
                //   onPressed: () {
                //     navigationBloc.add(const NavigationEvent.navigateTo(
                //       route: 'profile',
                //       type: NavigationType.PUSH,
                //       args: ProfileScreenArguments(mode: ProfileScreenMode.EDIT),
                //     ));
                //   },
                //   icon: const Icon(
                //     Icons.edit,
                //     color: Colors.grey,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
