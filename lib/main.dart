import 'package:flutter/material.dart'; //contains build in widgets + base class to create own widgets
import 'package:marq_app/page/overview_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final String title = 'Marquably Aufgaben';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Color(0xFFf6f5ee),
      ),
      home: OverviewPage(),
    );
  }
}
