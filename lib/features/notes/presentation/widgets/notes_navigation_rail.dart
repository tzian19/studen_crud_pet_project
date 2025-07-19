import 'package:flutter/material.dart';

class NotesNavigationRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const NotesNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      backgroundColor: Colors.grey[400],
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.menu_book),
          label: Text('View Notes'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.edit),
          label: Text('Edit Note'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.delete),
          label: Text('Delete Note'),
        ),
      ],
    );
  }
}