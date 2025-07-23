// domain/entities/note.dart

class Note {
  final String id;
  final String title;
  final String content;
  final String imageUrl;

  var count;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
