import 'package:flutter/material.dart';
import '../widgets/notes_navigation_rail.dart';

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  int _selectedIndex = 0;
  bool _isRailExtended = false;

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
            extended: _isRailExtended,
            onLeadingTap: () {
              setState(() {
                _isRailExtended = !_isRailExtended;
              });
            },
          ),
          Expanded(
            child: Center(
              child: Text('Selected index: $_selectedIndex'),
            ),
          ),
        ],
      ),
    );
  }
}