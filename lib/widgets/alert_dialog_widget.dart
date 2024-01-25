import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Delete"),
      content: const Text("Are you sure you want to delete all emotions?"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
