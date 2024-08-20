import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/components/note_settings.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function() onEditTap;
  final void Function() onDeleteTap;
  const NoteTile(
      {super.key,
      required this.text,
      required this.onEditTap,
      required this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).colorScheme.primary),
      child: ListTile(
          title: Text(
            text,
            style: GoogleFonts.dmSerifText(
                fontSize: 20.0,
                color: Theme.of(context).colorScheme.inversePrimary),
          ),
          trailing: Builder(
            builder: (context) => IconButton(
                icon: const Icon(Icons.more_vert),
                color: Theme.of(context).colorScheme.inversePrimary,
                onPressed: () => showPopover(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    context: context,
                    bodyBuilder: (context) => NoteSettings(
                          onEditTap: onEditTap,
                          onDeleteTap: onDeleteTap,
                        ))),
          )),
    );
  }
}
