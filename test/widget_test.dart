// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

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
  });

//First way of DELETE Testing
  /*  testWidgets('Delete Todo', (tester) async {
/*     final Todo todo =
        new Todo(id: 'id', title: 'test', description: 'test', isDone: false); */
    await tester.pumpWidget(const ProviderScope(
        child: MaterialApp(
            home: TodoWidget(
      todo: Todo(id: 'id', title: 'test', description: 'test', isDone: false),
    ))));

    expect(find.byType(IconSlideAction), findsNothing);
    await tester.dragFrom(Offset.zero, const Offset(100, 0));
    await tester.pump(const Duration(seconds: 10));
    expect(find.byType(IconSlideAction), findsOneWidget);
    expect(find.byIcon(Icons.edit), findsOneWidget);

    await tester.drag(find.byType(Slidable), const Offset(100, 0));
    /* await tester.tap(deleteBtn); */
    await tester.pump(/* const Duration(seconds: 10) */);
  }); */

//Second way of DELETE Testing
  testWidgets('Delete Todo', (tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: TodoListWidget())));

    /* await tester.pumpAndSettle(); */

    final findTodo = find.descendant(
        of: find.byType(ListView), matching: find.byType(TodoWidget));
    expect(findTodo, findsOneWidget);

    await tester.drag(findTodo, const Offset(100, 0));
    await tester.pump(const Duration(seconds: 10));

/*     final foundSlidable = find.byType(Slidable);
    expect(foundSlidable, findsOneWidget); */

//This should actually be "Icons.delete" and not "Icons.edit", but it doesnt find the Icons.delete if you change it...
    final delete = find.byIcon(Icons.delete);
    expect(delete, findsOneWidget);

    await tester.tap(delete);
    await tester.pumpAndSettle();
  });
}
