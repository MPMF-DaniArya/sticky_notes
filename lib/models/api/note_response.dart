class NoteResponse {
  List<NotesData>? listNotes;

  NoteResponse({this.listNotes});

  NoteResponse.fromJson(Map<String,dynamic> json){
    if (json['data'] != null){
      listNotes = <NotesData>[];
      json['data']['notes'].forEach((note) {
        listNotes!.add(NotesData.fromjson(note));
      });
    }
  }
}

class NotesData {
  int? id;
  String? title;
  String? description;
  String? image;
  String? color;
  Reactions? reactions;

  NotesData(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.color,
      this.reactions});

  NotesData.fromjson(Map<String, dynamic> json) {
      id = json['id'] ?? 0;
      title = json['title'] ?? 'Judul tidak ada';
      description = json['description'] ?? 'Deksripsi tidak ada';
      image = json['image'];
      color = json['color'] ?? '87CEEB';

      if (json['reactions'] != null) {
        reactions = Reactions.fromJson(json['reactions']);
      }
  }
}

class Reactions {
  int? like;
  int? heart;
  int? laugh;
  int? surprised;
  int? fire;

  Reactions({this.like, this.heart, this.laugh, this.surprised, this.fire});

  Reactions.fromJson(Map<String, dynamic> json) {
    like = json['like'] ?? 0;
    heart = json['heart'] ?? 0;
    laugh = json['laugh'] ?? 0;
    surprised = json['surprised'] ?? 0;
    fire = json['fire'] ?? 0;
  }
}
