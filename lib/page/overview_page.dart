import 'package:flutter/material.dart';
import 'package:marq_app/main.dart';
import 'package:marq_app/widget/add_todo_dialog.dart';

class OverviewPage extends StatefulWidget {
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Container(),
      Container(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
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
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
        onPressed: (() => showDialog(
              builder: (context) => AddTodoDialogWidget(),
              context: context,
            )),
      ),
    );
  }
}
