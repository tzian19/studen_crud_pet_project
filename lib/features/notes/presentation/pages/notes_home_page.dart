import 'package:flutter/material.dart';
import 'package:studen_crud_pet_project/features/notes/presentation/pages/note_view_page.dart';
import '../widgets/notes_navigation_rail.dart';
import '../widgets/note_card.dart';
import '../../domain/entities/note.dart';
class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});
  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}
class _NotesHomePageState extends State<NotesHomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;
  List<Note> notes = []; // Add this line to store notes
@override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Initialize notes with hardcoded values
    notes = [
      Note(id: '1', imageUrl: 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT_xpZgQB0cg1nASNeyvx8lG5UpEnC9VzMItvN-mrQvuXUPOD2wZZqhY5tzy8KN1ACRvMkObkqjizVRHSJ-RYvBaw', title: 'First Note', content: 'This is the first note content', count: 1),
      Note(id: '2', imageUrl: '', title: 'Second Note', content: 'This is the second note content', count: 2),
      Note(id: '3', imageUrl: '', title: 'Third Note', content: 'This is the third note content', count: 3),
      Note(id: '4', imageUrl: '', title: 'Forth Note', content: 'This is the fourth note content', count: 4),
      Note(id: '5', imageUrl: '', title: 'Fifth Note', content: 'This is the fifth note content', count: 5),
      Note(id: '6', imageUrl: '', title: 'Sixth Note', content: 'This is the sixth note content', count: 6),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NotesNavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
                _tabController.animateTo(index);
              });
            },
            
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  color: Color.fromRGBO(93, 67, 134, 1),
                  child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return NoteCard(
                        image: Image.network(
                          (note.imageUrl).isEmpty
                              ? 'https://cdn-icons-png.flaticon.com/512/1250/1250680.png'
                              : note.imageUrl,
                        ),
                      title: note.title,
                      content: note.content,
                      count: note.count,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoteViewPage(
                                note: note,
                                onEdit: (note) {
                                  // TODO: Implement edit functionality
                                },
                                onDelete: (id) {
                                  setState(() {
                                    notes.removeWhere((n) => n.id == id);
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                        },
                    );
                  },
                ),
                ),
                Container(
                  color: Colors.green[50], // Light green background for Edit Notes
                  child: Center(
                  child: Text('Edit Notes'),
                ),
                ),
                Container(
                  color: Colors.red[50], // Light red background for Delete Notes
                  child: Center(
                  child: Text('Delete Notes'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement add note functionality
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: const Icon(Icons.add),
        label: const Text('Add', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}