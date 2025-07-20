import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Image image;
  final String title;
  final String content;
  final int count;

  const NoteCard({
    super.key,
    required this.image,
    required this.title,
    required this.content,
    required this.count,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: SizedBox(
          width: 50,
          child: image ,
        ),
        title: Text(title),
        subtitle: Text(content),
        trailing: Text('$count+'),
      ),
    );
  }
}