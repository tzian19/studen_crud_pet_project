
class Note {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final int count;
  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    this.count = 0,
  });
  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    int? count,
  }) 
  {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      count: count ?? this.count,
    );
  }
}