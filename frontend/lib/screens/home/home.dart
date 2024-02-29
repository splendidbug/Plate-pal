import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/screens/home/views/views.dart';
import 'package:frontend/screens/home/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    // final chatBloc = BlocProvider.of<ChatBloc>(context);

    settingsBloc.add(const SettingsEvent.initial());
    // homeBloc.add(const HomeEvent.reconnect());
    // chatBloc.add(const ChatEvent.chats());

    return BlocListener<NavigationBloc, NavigationState>(
      listener: _navigationListner,
      child: const HomeView(),
    );
  }

  void _navigationListner(BuildContext context, NavigationState state) {
    if (state.type != NavigationType.POP_BACK) return;

    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    // final chatBloc = BlocProvider.of<ChatBloc>(context);

    settingsBloc.add(const SettingsEvent.initial());
    // chatBloc.add(const ChatEvent.chats());
    // chatBloc.add(const ChatEvent.reset());
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static List<Widget> views = [
    FeedViewV2(),
    SizedBox(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);

    final controller = PageController();

    return Scaffold(
      body: PageView(
        controller: controller,
        children: views,
        onPageChanged: (index) => homeBloc.add(HomeEvent.navigateTo(view: index)),
      ),
      bottomNavigationBar: BooperBottomNavigation(
        controller: controller,
      ),
    );
  }
}
