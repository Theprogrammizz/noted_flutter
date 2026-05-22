import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNotesScreen extends ConsumerStatefulWidget {
  const AddNotesScreen({super.key});

  @override
  ConsumerState<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends ConsumerState<AddNotesScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: () {
              
            }, icon: Icon(Icons.check_rounded),),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              SizedBox(height: 10,),
              TextField(
                controller: titleController,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(
                  hintText: "Title"
                ),
              ),
              SizedBox(height: 20,),
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
                  decoration: InputDecoration(
                    hintText: "Write your mind.....",
                    border: InputBorder.none
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