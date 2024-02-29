import 'package:flutter/material.dart';

class BooperPrimaryButton extends ButtonStyle {
  const BooperPrimaryButton(BuildContext context);
}

class BooperSecondaryButton extends ButtonStyle {
  BooperSecondaryButton(BuildContext context)
      : super(
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.secondary,
          ),
          foregroundColor: MaterialStateProperty.all(
            Theme.of(context).textTheme.button!.color,
          ),
        );
}

class BooperTertiaryButton extends ButtonStyle {
  BooperTertiaryButton(BuildContext context)
      : super(
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.tertiary,
          ),
          foregroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
        );
}

class BooperPrimaryCircleButton extends ButtonStyle {
  BooperPrimaryCircleButton(BuildContext context, double size)
      : super(
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.primary,
          ),
          padding: MaterialStateProperty.all(EdgeInsets.all(size / 4)),
          shape: MaterialStateProperty.all(const CircleBorder()),
        );
}

class BooperSecondaryCircleButton extends ButtonStyle {
  BooperSecondaryCircleButton(BuildContext context, double size)
      : super(
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.secondary,
          ),
          padding: MaterialStateProperty.all(EdgeInsets.all(size / 4)),
          shape: MaterialStateProperty.all(const CircleBorder()),
        );
}

class BooperTertiaryCircleButton extends ButtonStyle {
  BooperTertiaryCircleButton(BuildContext context, double size)
      : super(
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.tertiary,
          ),
          padding: MaterialStateProperty.all(EdgeInsets.all(size / 4)),
          shape: MaterialStateProperty.all(const CircleBorder()),
        );
}
