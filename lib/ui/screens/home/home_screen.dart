import 'package:flutter/material.dart';
import 'package:todo_application/ui/screens/home/tabs/list_tab/list_tab.dart';
import 'package:todo_application/ui/screens/home/tabs/settings_tab/settings_tab.dart';

import '../bottom_sheets/add_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  static const routename = "homescreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSelectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarbuild(),
      bottomNavigationBar: buttonnavbarbuild(),
      floatingActionButton: fabbuild(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: currentSelectedTabIndex == 0 ? ListTab() : SettingsTab(),
    );
  }

  PreferredSizeWidget appbarbuild() => AppBar(
    title: const Text("To Do List"),
    toolbarHeight: MediaQuery.of(context).size.height * .1,
  );

  Widget buttonnavbarbuild() => BottomAppBar(
    notchMargin: 8,
    shape: const CircularNotchedRectangle(),
    clipBehavior: Clip.hardEdge,
    child: BottomNavigationBar(
        onTap: (index) {
          currentSelectedTabIndex = index;
          setState(() {});
        },
        currentIndex: currentSelectedTabIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
        ]),
  );

  Widget fabbuild() => FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const AddBottomSheet(),
            ));
      },
      child: const Icon(Icons.add));
}
