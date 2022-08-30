// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marq_app/main.dart';
import 'package:marq_app/model/todo_model.dart';
import 'package:marq_app/provider/todo_provider.dart';
import 'package:marq_app/widget/add_todo_dialog.dart';
import 'package:marq_app/widget/todo_form_widget.dart';
import 'package:marq_app/widget/todo_list_widget.dart';
import 'package:marq_app/widget/todo_widget.dart';

/* import 'package:marq_app/main.dart';
import 'package:marq_app/widget/todo_form_widget.dart'; */
//import 'package:marq_app/widget/add_todo_dialog.dart';

void main() {
  testWidgets('Add Todo', (tester) async {
    await tester.pumpWidget(ProviderScope(
        child: MaterialApp(
      home: AddTodoDialog(),
    )));

    //Find all Widgets needed --> Add Input Title/Description, Add Button
    final addTitle = find.byKey(const ValueKey("addTitle"));
    final addDescription = find.byKey(const ValueKey("addDescription"));
    final addSaveBtn = find.byKey(const ValueKey("addSaveBtn"));

    expect(addTitle, findsOneWidget);
    expect(addDescription, findsOneWidget);
    expect(addSaveBtn, findsOneWidget);

    // Execute actual test
    await tester.enterText(addTitle, "Tester Title");
    await tester.enterText(addDescription, "Tester Description");
    await tester.tap(addSaveBtn);

    await tester.pump(); //Rebuild Widget

    //Check outputs
    expect(find.text("Tester Title"), findsOneWidget);
    expect(find.text("Tester Description"), findsOneWidget);
  });

  testWidgets('Delete Todo', (tester) async {
    final Todo todo =
        new Todo(id: 'id', title: 'test', description: 'test', isDone: false);
    bool called;
    await tester.pumpWidget(const ProviderScope(
        child: MaterialApp(
            home: Material(
                child: TodoWidget(
      todo: Todo(id: 'id', title: 'test', description: 'test', isDone: false),
    )))));

    /* expect(called, isNull); */

    final deleteBtn = find.byKey(const ValueKey("deleteBtn"));
    expect(deleteBtn, findsOneWidget);

    await tester.tap(deleteBtn);
    await tester.pump(/* const Duration(seconds: 10) */);
  });
}
