import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

class NotesNavigationRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool extended;
  final VoidCallback onLeadingTap;

  const NotesNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.extended,
    required this.onLeadingTap,
  });

  Icon leadingLogo(int selectedPage){
    
    switch (selectedPage) {
      case 0:
        return const Icon(Icons.menu_book);
      case 1:
        return const Icon(Icons.edit);
      case 2:
        return const Icon(Icons.delete);
      default:
        return const Icon(Icons.menu);
    }
  }


  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      extended: extended,
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      backgroundColor: Colors.grey[400],
      labelType: NavigationRailLabelType.none,
      
      leading: Column (
         crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            IconButton(
            icon: leadingLogo(selectedIndex),
            tooltip: 'Extend Navigation',
            onPressed: onLeadingTap,
          ),
         ],
      ),
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