import 'package:flutter/material.dart';
import '../widgets/notes_navigation_rail.dart';
import '../widgets/note_card.dart';

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  int _selectedIndex = 0;

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
              });
            },
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    // Switch content based on _selectedIndex
    switch (_selectedIndex) {
      case 0:
        return ListView(
          children: [
            NoteCard(title: "Note 1", content: "Sample content", count: 100),
            // ... more notes
          ],
        );
      case 1:
        return Center(child: Text("Edit Note Page"));
      case 2:
        return Center(child: Text("Delete Note Page"));
      default:
        return Container();
    }
  }
}