import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void dialogBox({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text("Are you sure?"),
        content: Text("This note will we deleted."),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.green.shade300,
            ),
            child: Text(
              "Cancel",
              style: GoogleFonts.ubuntu(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.red.shade300,
            ),
            child: Text(
              "Delete",
              style: GoogleFonts.ubuntu(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
