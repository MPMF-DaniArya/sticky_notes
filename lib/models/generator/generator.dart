import 'package:sticky_notes/models/api/login_response.dart';
import 'package:sticky_notes/models/api/note_response.dart';

class ModelGenerator {
  static ModelGenerator instance = ModelGenerator();

  get classes {
    return {
      LoginResponse: (json) => LoginResponse.fromJson(json),
      NoteResponse: (json) => NoteResponse.fromJson(json)
    };
  }

  static T? resolve<T>(Map<String, dynamic>? json) {
    if (instance.classes[T] == null) {
      throw 'Tipe $T tidak ditemukan. Pastikan telah diregister di generator';
    }
    return instance.classes[T](json);
  }
}
