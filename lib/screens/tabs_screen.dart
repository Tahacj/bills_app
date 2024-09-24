import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import 'export_owners_screen.dart';
import 'import_owners_sceen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pages = [
    {
      "page": const ImportOwnersScreen(),
      "title": "Imports",
    },
    {
      "page": const ExportOwnersScreen(),
      "title": "Exports",
    },
  ];

  // @override
  // void initState() {
  //   _pages = [
  //     {
  //       "page": ImportsScreen(),
  //       "title": "Imports",
  //     },
  //     {
  //       "page": ExportsScreen(),
  //       "title": "Exports",
  //     },
  //   ];
  //   super.initState();
  // }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(_pages[_selectedPageIndex]["title"])),
      ),
      // drawer: const MainDrawer(),
      body: _pages[_selectedPageIndex]["page"],
      extendBody: false,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.purple[900],
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.get_app_outlined),
            activeIcon: const Icon(Icons.get_app),
            label: "Imports",
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            activeIcon: const Icon(Icons.outbox),
            icon: const Icon(Icons.outbox_outlined),
            label: "exports",
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
