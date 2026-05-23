import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noted_flutter/providers/notes/notes_provider.dart';
import 'package:noted_flutter/screens/main/update_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  

  @override
  Widget build(BuildContext context) {
    final notesStream = ref.watch(notesStreamProvider);
    return notesStream.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Noted", style: GoogleFonts.ubuntu()),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),

            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              itemCount: data.length,

              itemBuilder: (context, index) {
                final note = data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UpdateScreen(note: note);
                        },
                      ),
                    );
                  },
                  onLongPress: () {},
                  child: NoteCard(text: note.title, body: note.body),
                );
              },
            ),
          ),
        );
      },
      error: (error, _) {
        return Scaffold(body: Center(child: Text(error.toString())));
      },
      loading: () {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: Color(0xFF173200)),
          ),
        );
      },
    );
  }
}

class NoteCard extends StatelessWidget {
  final String text;
  final String body;

  const NoteCard({super.key, required this.text, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 54, 124, 57),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: GoogleFonts.ubuntu(fontSize: 18, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(
            body,
            style: GoogleFonts.ubuntu(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
