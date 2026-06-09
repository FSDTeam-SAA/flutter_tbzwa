
class NoteModel {
  final String id;
  final String title;
  final String content;
  final DateTime updatedAt;
  final String? type; // e.g., 'vocabulary', 'summary', 'tips'

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.updatedAt,
    this.type,
  });
}

class NoteVersionModel {
  final String id;
  final String noteId;
  final String content;
  final DateTime createdAt;
  final String label; // e.g., 'Current Version', 'Auto saved', etc.

  NoteVersionModel({
    required this.id,
    required this.noteId,
    required this.content,
    required this.createdAt,
    required this.label,
  });
}
