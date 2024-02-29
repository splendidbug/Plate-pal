import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/common/common.dart';
import 'package:frontend/infrastructure/infrastructure.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ProfileHeader(),
        ProfileBody(),
        ProfileActions(),
      ],
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopSurface(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 64,
          left: 24,
          right: 24,
        ),
        child: Column(
          children: [
            Text(
              "Profile",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.inverseTextColor,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            const UserCard(),
          ],
        ),
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.tune),
              title: const Text('Preferences'),
              onTap: () {
                navigationBloc.add(const NavigationEvent.navigateTo(
                  route: 'preferences',
                  type: NavigationType.PUSH,
                ));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) => SwitchListTile(
                value: state.themeMode.value(context),
                title: const Text('Theme'),
                secondary: Icon(state.themeMode.icon),
                onChanged: (value) => settingsBloc.add(SettingsEvent.changeTheme(
                  themeMode: state.themeMode.inverse(context),
                )),
              ),
            ),
            // BlocBuilder<SettingsBloc, SettingsState>(
            //   builder: (context, state) => ListTile(
            //     leading: const Icon(Icons.health_and_safety),
            //     trailing: Chip(
            //       label: Text(state.apiVersion, style: const TextStyle(color: Colors.grey)),
            //     ),
            //     title: const Text('Health Check'),
            //     onTap: () => settingsBloc.add(const SettingsEvent.healthCheck()),
            //   ),
            // ),
            // BlocBuilder<HomeBloc, HomeState>(
            //   builder: (context, state) => ListTile(
            //     leading: const Icon(Icons.rss_feed),
            //     trailing: Chip(
            //       label: Text(state.socketState.name),
            //       backgroundColor: state.socketState.backgroundColor,
            //     ),
            //     title: const Text('Coordinator'),
            //     onTap: () {
            //       if (state.socketState == WebSocketState.DISCONNECTED) {
            //         homeBloc.add(const HomeEvent.reconnect());
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class ProfileActions extends StatelessWidget {
  const ProfileActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 36,
        vertical: 24,
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              // onPressed: () => userBloc.add(const UserEvent.logout()),
              onPressed: () {},
              style: BooperTertiaryButton(context),
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () async {
                if (await BooperConfirmationDialog.show(
                  context: context,
                  title: "Confirm",
                  body: const Text(
                    "No More Boops ?",
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    const BooperAction(label: "No", type: BooperActionType.HAPPY, payload: false),
                    const BooperAction(label: "Yes", type: BooperActionType.DANGER, payload: true),
                  ],
                )) {
                  // userBloc.add(const UserEvent.delete());
                }
              },
              style: BooperPrimaryButton(context).copyWith(
                  backgroundColor: MaterialStateProperty.all(Colors.red.shade700),
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              icon: const Icon(Icons.delete_forever),
              label: const Text("Delete"),
            ),
          )
        ],
      ),
    );
  }
}
