import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NotesHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NotesHomePage extends StatelessWidget {
  const NotesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 100,
            color: Colors.grey[400],
            child: Column(
              children: [
                const SizedBox(height: 24),
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {},
                ),
                const SizedBox(height: 24),
                SidebarButton(
                  icon: Icons.menu_book,
                  label: "View Notes",
                  selected: true,
                ),
                SidebarButton(
                  icon: Icons.edit,
                  label: "Edit Note",
                ),
                SidebarButton(
                  icon: Icons.delete,
                  label: "Delete Note",
                ),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: Container(
              color: const Color(0xFF6C4A8A), // Purple background
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80, top: 8),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Card(
                            color: Colors.purple[50],
                            child: ListTile(
                              leading: Container(
                                width: 48,
                                height: 48,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image, color: Colors.grey),
                              ),
                              title: const Text("Note"),
                              subtitle: const Text(
                                "Supporting line text lorem ipsum dolor sit amet, consectetur.",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: const Text(
                                "100+",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Add Button
                  Positioned(
                    right: 24,
                    bottom: 24,
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.deepPurple,
                      icon: const Icon(Icons.add),
                      label: const Text("Add"),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const SidebarButton({
    super.key,
    required this.icon,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: selected
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            )
          : null,
      child: ListTile(
        leading: Icon(icon, color: Colors.black87),
        title: Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
        dense: true,
        onTap: () {},
      ),
    );
  }
}