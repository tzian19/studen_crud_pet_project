import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  final int count;

  const NoteCard({
    super.key,
    required this.title,
    required this.content,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(content),
        trailing: Text('$count+'),
      ),
    );
  }
}