import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:noted_flutter/providers/notes/notes_provider.dart';

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
          appBar: AppBar(title: Text("Notes")),
          body: Padding(
            padding: const EdgeInsets.all(12),

            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              itemCount: data.length,

              itemBuilder: (context, index) {
                final note = data[index];
                return NoteCard(text: note.title, body: note.body,);
              },
            ),
          ),
        );
      },
      error: (error, _) {
        return Scaffold(body: Center(child: Text(error.toString()),));
      },
      loading: () {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
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
          Text(text, style: const TextStyle(fontSize: 16, color: Colors.white)),
          SizedBox(height: 5,),
          Text(body, style: const TextStyle(fontSize: 14, color: Colors.white)),
        ],
      ),
    );
  }
}
