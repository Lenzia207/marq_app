import 'package:flutter/material.dart';
import 'package:marq_app/main.dart';
import 'package:marq_app/widget/add_todo_dialog.dart';

import '../widget/todo_list_widget.dart';
import '../widget/completed_widget.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const TodoListWidget(),
      const CompletedWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: "TO DO's",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            label: "Geschafft!",
          ),
        ],
      ),
      body: tabs[selectedIndex],

      //Add TO DO Task BUTTON
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Colors.amber,
        onPressed: (() => showDialog(
              builder: (context) => AddTodoDialog(),
              context: context,
            )),
        child: const Icon(Icons.add),
      ),
    );
  }
}
