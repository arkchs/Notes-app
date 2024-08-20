import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String text;
  final Widget leading;
  final void Function()? onTap;

  const DrawerTile(
      {super.key,
      required this.text,
      required this.leading,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      leading: leading,
      onTap: onTap,
    );
  }
}
