import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_flutter/models/notes_model.dart';
import 'package:noted_flutter/providers/notes/notes_notifier.dart';
import 'package:noted_flutter/services/notes_services.dart';

final notesServiceProvider = Provider<NotesServices>((ref) {
  return NotesServices();
});

final notesProvider = AsyncNotifierProvider<NotesNotifier, List<NotesModel>>(NotesNotifier.new);

final notesStreamProvider = StreamProvider<List<NotesModel>>((ref) {
  final services = ref.watch(notesServiceProvider);
  return services.getNotes();
});