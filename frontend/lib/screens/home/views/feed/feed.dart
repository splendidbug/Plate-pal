import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/blocs/chat/chat_bloc.dart';
import 'package:frontend/blocs/chat/chat_event.dart';
import 'package:frontend/blocs/recpie/recpie_bloc.dart';
import 'package:frontend/blocs/recpie/recpie_state.dart';
import 'package:frontend/blocs/user/user_bloc.dart';
import 'package:frontend/blocs/user/user_event.dart';
import 'package:frontend/blocs/user/user_state.dart';
import 'package:frontend/di/di.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/widgets.dart';

const int BOTTOM_NAV_HEIGHT = 56;

class FeedViewV2 extends StatelessWidget {
  final StreamController<String> _streamController = StreamController.broadcast();

  FeedViewV2({super.key}) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(
          children: [
            FeedViewHeader(
              stream: _streamController,
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: FeedViewBody(
                search_form: _streamController.stream,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedViewHeader extends StatelessWidget {
  static final GlobalKey<FormBuilderState> form = GlobalKey<FormBuilderState>();
  final StreamController<String> stream;

  const FeedViewHeader({super.key, required this.stream});

  @override
  Widget build(BuildContext context) {
    return TopSurface(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 64,
              left: 24,
              right: 24,
            ),
            child: BooperHeaderRow(
              child: Text(
                "Home",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Theme.of(context).colorScheme.inverseTextColor,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 4),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: FormBuilder(
                    onChanged: () {
                      DI.logger().i(form.currentState!.getRawValue('search'));
                      stream.add(form.currentState!.getRawValue('search'));
                    },
                    initialValue: {'search': ''},
                    key: form,
                    child: FormBuilderTextField(
                      name: "search",
                      decoration: BooperInputDecoration(context).copyWith(
                          labelText: 'Search',
                          suffixIcon: IconButton(
                            onPressed: () => form.currentState?.reset(),
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
            child: Material(
              color: Theme.of(context).colorScheme.primary,
              child: TabBar(
                indicatorColor: Theme.of(context).colorScheme.tertiary,
                labelColor: Theme.of(context).colorScheme.tertiary,
                unselectedLabelColor: Theme.of(context).colorScheme.inverseTextColor,
                tabs: const [
                  Tab(
                    icon: Icon(
                      Icons.feed,
                    ),
                    text: "Feed",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.history,
                    ),
                    text: "History",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.inventory,
                    ),
                    text: "Inventory",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FeedViewBody extends StatelessWidget {
  final Stream<String> search_form;

  const FeedViewBody({super.key, required this.search_form});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: TabBarView(
        children: [
          FeedTab(
            search_form: search_form,
          ),
          HistoryTab(
            search_form: search_form,
          ),
          InventoryView(
            search_form: search_form,
          ),
        ],
      ),
    );
  }
}

class FeedTab extends StatelessWidget {
  final Stream<String> search_form;

  const FeedTab({super.key, required this.search_form});

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    final height = MediaQuery.of(context).size.height * 0.6;

    return SingleChildScrollView(
      child: SizedBox(
        height: height,
        child: BlocBuilder<RecpieBloc, RecpieState>(
          builder: (context, state) => StreamBuilder(
            stream: search_form,
            builder: (context, snapshot) {
              final query = snapshot.data;

              List<Recpie> list;

              if (query != null && (query as String).trim().isNotEmpty) {
                list = state.recpies.where((x) => x.recipe_name.toLowerCase().contains(query.toLowerCase())).toList();
              } else {
                list = state.recpies;
              }

              return BooperListView.builder(
                count: list.length,
                empty: const Text("No recipes"),
                builder: (context, index) => ListTile(
                  title: Text(list[index].recipe_name),
                  subtitle: Text(list[index].prep_time),
                  onTap: () {
                    chatBloc.add(CEOpen(ChatScreenArguments(
                      recpie: list[index].recipe_name,
                    )));
                  },
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.check_circle,
                    ),
                    color: Colors.green.shade700,
                    onPressed: () => userBloc.add(UEEat(
                        recpie: state
                            .recpies[
                                state.recpies.indexWhere((element) => element.recipe_name == list[index].recipe_name)]
                            .recipe_name)),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class HistoryTab extends StatelessWidget {
  final Stream search_form;

  const HistoryTab({super.key, required this.search_form});

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final height = MediaQuery.of(context).size.height * 0.6;

    return SingleChildScrollView(
      child: SizedBox(
        height: height,
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) => StreamBuilder(
            stream: search_form,
            builder: (context, snapshot) {
              final query = snapshot.data;

              List<String> list;

              if (query != null && (query as String).trim().isNotEmpty) {
                list = state.history.where((x) => x.toLowerCase().contains(query.toLowerCase())).toList();
              } else {
                list = state.history;
              }

              return BooperListView.builder(
                count: list.length,
                empty: const Text("let's eat something"),
                builder: (context, index) => ListTile(
                  title: Text(list[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red.shade700,
                    onPressed: () => userBloc.add(
                      UEHDelete(index: state.history.indexOf(list[index])),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class InventoryView extends StatelessWidget {
  final Stream search_form;

  const InventoryView({super.key, required this.search_form});

  @override
  Widget build(BuildContext context) {
    final inventoryBloc = BlocProvider.of<InventoryBloc>(context);
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SingleChildScrollView(
          child: SizedBox(
            height: height * 0.5,
            child: BlocBuilder<InventoryBloc, InventoryState>(
              builder: (context, state) => StreamBuilder(
                stream: search_form,
                builder: (context, snapshot) {
                  final query = snapshot.data;

                  List<String> list;

                  if (query != null && (query as String).trim().isNotEmpty) {
                    list = state.items.where((x) => x.toLowerCase().contains(query.toLowerCase())).toList();
                  } else {
                    list = state.items;
                  }

                  return BooperListView.builder(
                    count: list.length,
                    empty: const Text("No ingredients"),
                    builder: (context, index) => ListTile(
                      title: Text(list[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red.shade700,
                        onPressed: () => inventoryBloc.add(IEDelete(
                          index: state.items.indexOf(list[index]),
                        )),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    inventoryBloc.add(const IEScan());
                  },
                  style: BooperTertiaryButton(context),
                  icon: const Icon(Icons.add),
                  label: const Text("Scan"),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    inventoryBloc.add(const IEClear());
                  },
                  style: BooperPrimaryButton(context).copyWith(
                    backgroundColor: MaterialStateProperty.all(Colors.red.shade700),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  icon: const Icon(Icons.delete_forever),
                  label: const Text("Clear All"),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
