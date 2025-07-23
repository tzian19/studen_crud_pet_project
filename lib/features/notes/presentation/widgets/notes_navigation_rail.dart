import 'package:flutter/material.dart';

class NotesNavigationRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const NotesNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  Icon leadingLogo(int selectedPage){
    
    double _size = 40;

    switch (selectedPage) {
      case 0:
        return Icon(Icons.menu_book, size: _size,);
      case 1:
        return Icon(Icons.edit,size: _size);
      case 2:
        return Icon(Icons.delete, size: _size);
      default:
        return Icon(Icons.menu, size: _size);
    }
  }


  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      backgroundColor: Colors.grey[400],
      labelType: NavigationRailLabelType.all,
      
      leading: Padding (
        padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
        child: 
          leadingLogo(selectedIndex),
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Tooltip( 
            message: 'Menu',
            child: 
              Icon(Icons.menu_book),
            ),
          label: Text('View Notes'),
        ),
        NavigationRailDestination(
          icon: Tooltip( 
            message: 'Edit',
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