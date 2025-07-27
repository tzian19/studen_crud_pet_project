import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/note.dart';

class AddNotePage extends StatefulWidget {
  final Function(Note) onAdd;
  final int noteType; // 0: Regular, 1: Music, 2: Image

  const AddNotePage({
    super.key,
    required this.onAdd,
    this.noteType = 0,
  });

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageUrlController.text = image.path;
      });
    }
  }

  Future<void> _pickAudio() async {
    // TODO: Implement custom audio picker if needed
  }

  @override
  void initState() {
    super.initState();
    _imageUrlController.text = widget.noteType == 1
        ? 'https://cdn-icons-png.flaticon.com/512/3659/3659784.png'
        : widget.noteType == 2
            ? 'https://cdn-icons-png.flaticon.com/512/1375/1375106.png'
            : '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_titleController.text.trim().isEmpty ||
        _contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and content cannot be empty')),
      );
      return;
    }

    final newNote = Note(
      id: DateTime.now().toString(),
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      imageUrl: _imageUrlController.text.trim(),
    );

    widget.onAdd(newNote);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final String noteType = widget.noteType == 0
        ? 'Note'
        : widget.noteType == 1
            ? 'Music Note'
            : 'Image Note';

    return Scaffold(
      appBar: AppBar(
        title: Text('Add $noteType'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNote,
            tooltip: 'Save Note',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(_titleController, 'Title'),
            const SizedBox(height: 12),
            _buildTextField(_contentController, 'Content', maxLines: 6),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    _imageUrlController,
                    widget.noteType == 1 ? 'Audio Path/URL' : 'Image Path/URL',
                  ),
                ),
                IconButton(
                  icon: Icon(
                    widget.noteType == 1 ? Icons.audio_file : Icons.image,
                  ),
                  onPressed:
                      widget.noteType == 1 ? _pickAudio : _pickImage,
                  tooltip:
                      widget.noteType == 1 ? 'Pick Audio' : 'Pick Image',
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_imageUrlController.text.trim().isNotEmpty)
              widget.noteType == 2
                  ? Image.network(
                      _imageUrlController.text.trim(),
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image),
                    )
                  : const Icon(Icons.audio_file, size: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
