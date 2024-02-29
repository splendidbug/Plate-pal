import 'package:flutter/material.dart';

class BooperListView extends StatelessWidget {
  final Widget Function(BuildContext, int) builder;
  final ScrollController? controller;
  final Widget? empty;
  final bool reverse;
  final int count;

  const BooperListView.builder({
    Key? key,
    required this.builder,
    required this.count,
    this.controller,
    this.empty,
    this.reverse = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: count != 0
          ? ListView.builder(
              itemCount: count,
              itemBuilder: builder,
              controller: controller,
              reverse: reverse,
            )
          : Center(
              child: empty,
            ),
    );
  }
}
