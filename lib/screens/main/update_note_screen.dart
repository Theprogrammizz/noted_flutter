import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noted_flutter/models/notes_model.dart';
import 'package:noted_flutter/providers/notes/notes_provider.dart';

class UpdateNoteScreen extends ConsumerStatefulWidget {
  final NotesModel note;
  const UpdateNoteScreen({super.key, required this.note});

  @override
  ConsumerState<UpdateNoteScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends ConsumerState<UpdateNoteScreen> {
  final bodyController = TextEditingController();
  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bodyController.text = widget.note.body;
    titleController.text = widget.note.title;
  }

  @override
  void dispose() {
    bodyController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Note", style: GoogleFonts.ubuntu(),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () async{
             final title = titleController.text.trim();
                final body = bodyController.text.trim();

                if (title.isEmpty || body.isEmpty) return;

                await ref.read(notesServiceProvider).updateNote(widget.note.id, title, body);

                if (context.mounted) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
          }, icon: Icon(Icons.check))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              TextField(
                style: GoogleFonts.ubuntu(fontSize: 20),
                controller: titleController,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(hintText: "Title"),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: TextField(
                  controller: bodyController,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  expands: true,
                  style: GoogleFonts.ubuntu(),
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
