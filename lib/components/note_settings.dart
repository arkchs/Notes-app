import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final void Function() onEditTap;
  final void Function() onDeleteTap;

  const NoteSettings(
      {super.key, required this.onEditTap, required this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: onEditTap,
          child: const Text(
            'Edit',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: onDeleteTap,
          child: const Text(
            'Delete',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
