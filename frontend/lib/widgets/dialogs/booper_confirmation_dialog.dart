import 'package:frontend/models/models.dart';
import 'package:flutter/material.dart';

class BooperConfirmationDialog extends StatelessWidget {
  final String title;
  final Widget body;
  final List<BooperAction> actions;

  const BooperConfirmationDialog({
    Key? key,
    required this.title,
    required this.body,
    required this.actions,
  }) : super(key: key);

  static Future<dynamic> show({
    required BuildContext context,
    required String title,
    required Widget body,
    List<BooperAction> actions = const [],
    bool dismissible = false,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) => BooperConfirmationDialog(
        title: title,
        body: body,
        actions: actions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: size.height * 0.5,
          maxWidth: size.width * 0.8,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              body,
              const SizedBox(
                height: 16,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Container(
                  transform: Matrix4.translationValues(0.0, 6, 0.0),
                  child: Row(
                    children: actions
                        .map((action) => Expanded(
                              child: TextButton(
                                onPressed: () => Navigator.pop(context, action.payload),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(action.type.backgroundColor),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  action.label,
                                  style: TextStyle(color: action.type.textColor),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      contentPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
    );
  }
}
