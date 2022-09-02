// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marq_app/model/todo_model.dart';
import 'package:marq_app/widget/add_todo_dialog.dart';
import 'package:marq_app/widget/todo_list_widget.dart';
import 'package:marq_app/widget/todo_widget.dart';

/* import 'package:marq_app/main.dart';
import 'package:marq_app/widget/todo_form_widget.dart'; */
//import 'package:marq_app/widget/add_todo_dialog.dart';

void main() {
  testWidgets('Add Todo', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: AddTodoDialog(),
        ),
      ),
    );

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
  });

//First way of DELETE Testing
  /*  testWidgets('Delete Todo', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: TodoWidget(
            todo: Todo(
                id: 'id', title: 'test', description: 'test', isDone: false),
          ),
        ),
      ),
    );

    expect(find.byType(Slidable), findsOneWidget);
    await tester.dragFrom(Offset.zero, const Offset(-1, 0));
    await tester.pump(const Duration(seconds: 1));

    final delete = find.byIcon(Icons.delete);
    expect(delete, findsOneWidget);

    await tester.tap(delete);
  }); */

//Second way of DELETE Testing
  testWidgets('Delete Todo', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: TodoListWidget(),
        ),
      ),
    );

    final findTodo = find.descendant(
        of: find.byType(ListView), matching: find.byType(TodoWidget));
    expect(findTodo, findsOneWidget);

    await tester.drag(findTodo, const Offset(-100, 0));
    await tester.pump(const Duration(seconds: 1));

    final delete = find.byIcon(Icons.delete);
    expect(delete, findsOneWidget);

    await tester.tap(delete);
    await tester.pumpAndSettle();
  });
}
