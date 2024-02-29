import 'package:flutter/material.dart';

class TopSurface extends StatelessWidget {
  final double? height;
  final Color? color;
  final Widget child;
  final AlignmentDirectional? stackAlignment;

  const TopSurface({
    Key? key,
    this.color,
    this.height,
    this.stackAlignment,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        alignment: stackAlignment ?? AlignmentDirectional.center,
        children: [
          Material(
            elevation: 8,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: color ?? Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}
