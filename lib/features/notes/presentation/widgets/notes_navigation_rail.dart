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
    
    double size = 40;

    switch (selectedPage) {
      case 0:
        return Icon(Icons.note, size: size);
      case 1:
        return Icon(Icons.audio_file, size: size);
      case 2:
        return Icon(Icons.text_snippet, size: size);
      default:
        return Icon(Icons.menu, size: size);
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
            message: 'Notes',
            child: 
              Icon(Icons.note),
            ),
          label: Text('Notes'),
        ),
        NavigationRailDestination(
          icon: Tooltip( 
            message: 'Audio',
            child: Icon(Icons.audio_file),
            ),
          label: Text('Audio Notes'),
        ),
        NavigationRailDestination(
          icon: Tooltip( 
            message: 'Text',
            child: Icon(Icons.text_snippet),
            ),
          label: Text('Text Notes'),
        ),
      ],
    );
  }
}