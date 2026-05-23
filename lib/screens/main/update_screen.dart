import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noted_flutter/models/notes_model.dart';
import 'package:noted_flutter/providers/notes/notes_provider.dart';
import 'package:noted_flutter/utils/utils.dart';

class UpdateScreen extends ConsumerStatefulWidget {
  final NotesModel note;
  const UpdateScreen({super.key, required this.note});

  @override
  ConsumerState<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends ConsumerState<UpdateScreen> {
  final bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bodyController.text = widget.note.body;
  }

  @override
  void dispose() {
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note.title, style: GoogleFonts.ubuntu(),),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "edit") {
                final body = bodyController.text.trim();

                if (body.isEmpty) return;

                if (context.mounted) {
                  Navigator.pop(context);
                }
              }

              if (value == "delete") {
                dialogBox(
                  context: context,
                  onTap: () async {
                    await ref
                        .read(notesServiceProvider)
                        .deleteNote(widget.note.id);

                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "edit",
                child: ListTile(leading: Icon(Icons.edit), title: Text("Edit")),
              ),
              PopupMenuItem(
                value: "delete",
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text("Delete"),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: bodyController,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  readOnly: true,
                  expands: true,
                  decoration: InputDecoration(
                    hintText: "Write your mind.....",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
