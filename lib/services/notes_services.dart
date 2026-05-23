import 'package:noted_flutter/models/notes_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotesServices {
  final supabase = Supabase.instance.client;

  Future<NotesModel> createNotes(String title, String body) async {
    final response = await supabase
        .from('notes')
        .insert({'title': title, 'body': body})
        .select()
        .single();

    return NotesModel.fromJson(response);
  }

  Stream<List<NotesModel>> getNotes() {
    return supabase
        .from("notes")
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) {
          return data.map<NotesModel>((json) {
            return NotesModel.fromJson(json);
          }).toList();
        });
  }

  Future<void> deleteNote(int id) async{
    await supabase.from("notes").delete().eq("id", id);
  }
}
