import 'package:frontend/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/models/models.dart';

class BooperBottomNavigation extends StatelessWidget {
  final PageController controller;

  const BooperBottomNavigation({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    final homeBloc = BlocProvider.of<HomeBloc>(context);

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.android,
              color: Colors.green.shade700,
            ),
            label: 'Chat',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: state.view,
        onTap: (index) {
          if (index == 1) {
            chatBloc.add(const CEOpen(ChatScreenArguments(recpie: 'GENERAL')));
          } else {
            homeBloc.add(HomeEvent.navigateTo(view: index));
            controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
    );
  }
}
