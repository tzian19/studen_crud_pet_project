import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Image image;
  final String title;
  final String content;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onPlay;
  final int count;
  final bool isAudioNote;
  const NoteCard({
    super.key,
    required this.image,
    required this.title,
    required this.content,
    required this.onTap,
    this.onDelete,
    this.onPlay,
    this.count = 0,
    this.isAudioNote = false,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: SizedBox(
          width: 50,
          height: 50,
          child: _buildImage(image),
        ),
        subtitle: Text(content),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isAudioNote)
              IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: onPlay,
                tooltip: 'Play Audio',
              ),
            IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: onDelete,
                color: Colors.red,
              tooltip: 'Delete Note',
            ),
          ],
              ),
        onTap: onTap,
      ),
    );

}
Widget _buildImage(Image image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: image.image is NetworkImage
          ? image
          : Builder(
              builder: (context) {
                final imageProvider = image.image;
                if (imageProvider is FileImage) {
                  final file = (imageProvider).file;
                  if (!file.existsSync()) {
                    return const Icon(Icons.broken_image);
  }
}
                return image;
              },
            ),
    );
  }
}