import 'package:flutter/material.dart';

class BooperInputDecoration extends InputDecoration {
  BooperInputDecoration(BuildContext context)
      : super(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        );
}
