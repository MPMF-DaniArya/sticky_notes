import 'package:sticky_notes/models/api/note_response.dart';
import 'package:sticky_notes/service/base_service.dart';

class NoteService extends BaseService {
  static NoteService instance = NoteService();

  Future<NoteResponse?> fetchNotes() async {
    return get(
      '/api/canvas/notes/mobile?canvas_id=1&page=1&per_page=25',
    );
  }
}
