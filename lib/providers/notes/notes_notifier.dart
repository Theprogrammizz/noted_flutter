import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_flutter/models/notes_model.dart';
import 'package:noted_flutter/providers/notes/notes_provider.dart';
import 'package:noted_flutter/services/notes_services.dart';

class NotesNotifier extends AsyncNotifier<List<NotesModel>>{

  late final NotesServices _services;

  @override
  Future<List<NotesModel>> build() async{
    _services = ref.watch(notesServiceProvider);
    return [];
  } 

  Future<void> createNotes(String title, String body) async{
    final note = await _services.createNotes(title, body);

    state = AsyncData([
      ...state.value ?? [],
      note,
    ]);
  }
}