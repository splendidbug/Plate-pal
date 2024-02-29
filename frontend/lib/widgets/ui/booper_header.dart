import 'package:flutter/material.dart';

import 'top_surface.dart';

class BooperHeader extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final Widget? trailing;

  const BooperHeader({
    Key? key,
    required this.child,
    this.leading,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopSurface(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
        ),
        child: BooperHeaderRow(
          leading: leading,
          trailing: trailing,
          child: child,
        ),
      ),
    );
  }
}

class BooperHeaderRow extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final Widget? trailing;

  const BooperHeaderRow({
    Key? key,
    required this.child,
    this.leading,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        showWidget(leading),
        child,
        showWidget(trailing),
      ],
    );
  }

  Widget showWidget(Widget? widget) {
    if (widget != null) {
      return Expanded(
        child: Wrap(
          alignment: WrapAlignment.start,
          children: [widget],
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
