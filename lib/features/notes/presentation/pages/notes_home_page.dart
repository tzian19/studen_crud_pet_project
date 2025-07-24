import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:studen_crud_pet_project/features/notes/presentation/pages/note_view_page.dart';
import '../widgets/notes_navigation_rail.dart';
import '../widgets/note_card.dart';
import '../../domain/entities/note.dart';
import 'add_note_page.dart';
import 'edit_note_page.dart';
class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  int _selectedIndex = 0;
  List<Note> notes = [];
  List<Note> musicNotes = [];
  List<Note> imageNotes = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  void initState() {
    super.initState();
    notes = [
      Note(
          id: '1',
        imageUrl: 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT_xpZgQB0cg1nASNeyvx8lG5UpEnC9VzMItvN-mrQvuXUPOD2wZZqhY5tzy8KN1ACRvMkObkqjizVRHSJ-RYvBaw',
          title: 'First Note',
        content: 'This is the first note content',
      ),
    ];
    
    musicNotes = [
      Note(
          id: '2',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3659/3659784.png',
        title: 'Music Note 1',
        content: 'This is a music note',
      ),
    ];
    
    imageNotes = [
      Note(
          id: '3',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/1375/1375106.png',
        title: 'Image Note 1',
        content: 'This is an image note',
      ),
    ];
  }
  List<Note> _getCurrentNotes() {
    switch (_selectedIndex) {
      case 0:
        return notes;
      case 1:
        return musicNotes;
      case 2:
        return imageNotes;
      default:
        return notes;
    }
  }
  void _handleNoteTap(Note note) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteViewPage(
              note: note,
              onEdit: (updatedNote) {
                setState(() {
              final currentNotes = _getCurrentNotes();
              final index = currentNotes.indexWhere((n) => n.id == updatedNote.id);
              if (index != -1) {
                currentNotes[index] = updatedNote;
              }
                });
              },
              onDelete: (id) {
                setState(() {
              final currentNotes = _getCurrentNotes();
              currentNotes.removeWhere((n) => n.id == id);
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
    }
  void _confirmDelete(Note note) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text('Delete Note'),
          ],
        ),
        content: Text('Are you sure you want to delete "${note.title}"?\nThis action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                final currentNotes = _getCurrentNotes();
                currentNotes.removeWhere((n) => n.id == note.id);
              });
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final currentNotes = _getCurrentNotes();
    
    return Scaffold(
      body: Row(
        children: [
          NotesNavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: Container(
              color: _selectedIndex == 0
                  ? Colors.white
                  : _selectedIndex == 1
                      ? Colors.blue[50]
                      : Colors.green[50],
              child: ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  final note = currentNotes[index];
                  return NoteCard(
                    image: Image.network(
                      note.imageUrl.isEmpty
                          ? 'https://cdn-icons-png.flaticon.com/512/1250/1250680.png'
                          : note.imageUrl,
                    ),
                    title: note.title,
                    content: note.content,
                    count: index + 1,
                    onTap: () => _handleNoteTap(note),
                    onDelete: () => _confirmDelete(note),
                  );
  },    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddNotePage(
                onAdd: (newNote) {
                  setState(() {
                    switch (_selectedIndex) {
                      case 0:
                        notes.add(newNote);
                        break;
                      case 1:
                        musicNotes.add(newNote);
                        break;
                      case 2:
                        imageNotes.add(newNote);
                        break;
                    }
                  });
                },
                noteType: _selectedIndex,
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: const Icon(Icons.add),
        label: Text(
          'Add ${_selectedIndex == 0 ? 'Note' : _selectedIndex == 1 ? 'Music Note' : 'Image Note'}',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
