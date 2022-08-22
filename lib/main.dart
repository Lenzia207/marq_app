import 'package:flutter/material.dart'; //contains build in widgets + base class to create own widgets
import 'package:marq_app/page/overview_page.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  static const String title = 'Marquably Aufgaben';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: const Color(0xFFf6f5ee),
        ),
        home: const OverviewPage(),
      );
}
