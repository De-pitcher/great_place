import 'package:flutter/material.dart';

Future<bool?> customDialog({
  required String title,
  required String msg,
  required BuildContext context,
  bool? isConfirmedNeeded,
  Function? onConfirmHandler,
}) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        if (isConfirmedNeeded != null && isConfirmedNeeded) ...[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
            child: const Text('NO'),
          ),
          TextButton(
            onPressed: () {
              if (onConfirmHandler != null) {
                onConfirmHandler();
              }

              Navigator.of(ctx).pop(true);
            },
            child: const Text('YES'),
          ),
        ] else
          TextButton(
            onPressed: () => onConfirmHandler!(),
            child: const Text('OK'),
          ),
      ],
    ),
  );
}
