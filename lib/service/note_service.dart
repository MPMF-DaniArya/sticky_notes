import 'package:sticky_notes/models/api/note_response.dart';
import 'package:sticky_notes/service/base_service.dart';

class NoteService extends BaseService {
  static NoteService instance = NoteService();

  Future<NoteResponse?> fetchNotes() async {
    return get(
      '/api/canvas/notes/mobile?canvas_id=6&page=1&per_page=25',
    );
  }

  Future<bool?> deleteNote({required int id}) async {
    return delete('/api/notes/$id');
  }
}
