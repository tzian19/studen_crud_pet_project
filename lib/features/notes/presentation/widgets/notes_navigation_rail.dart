import 'package:flutter/material.dart';

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
         crossAxisAlignment: CrossAxisAlignment.end,
        children: [
            IconButton(
            icon: leadingLogo(selectedIndex),
            tooltip: extended ? 'Minimize' : 'Expand',
            onPressed: onLeadingTap,
          ),
         ],
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Tooltip( 
            message: 'Menu',
            child: Icon(Icons.menu_book),
            ),
          label: Text('View Notes'),
        ),
        NavigationRailDestination(
          icon: Tooltip( 
            message: 'View',
            child: Icon(Icons.edit),
            ),
          label: Text('Edit Notes'),
        ),
        NavigationRailDestination(
          icon: Tooltip( 
            message: 'Delete',
            child: Icon(Icons.delete),
            ),
          label: Text('Delete Notes'),
        ),
      ],
    );
  }
}