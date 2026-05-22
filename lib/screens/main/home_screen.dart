import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<String> notes = [
    "Short note, this is it honey we the world gang",
    "Very very long note with lots of text inside it to make the card taller",
    "Todo list",
    "Another random note",
    "Flutter is amazing",
    "Keep-style UI",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      body: Padding(
        padding: const EdgeInsets.all(12),

        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          itemCount: notes.length,

          itemBuilder: (context, index) {
            return NoteCard(text: notes[index]);
          },
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final String text;

  const NoteCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
