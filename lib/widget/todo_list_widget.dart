import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marq_app/widget/todo_widget.dart';
//import 'package:riverpod/riverpod.dart';
import 'package:marq_app/model/todo_model.dart';
import 'package:marq_app/provider/todo_provider.dart';

class TodoListWidget extends ConsumerWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todosProvider);
    inspect(todos);

    //Render the todos in a scrollable list view --> ListView()
    return todos.isEmpty
        ? Center(
            child: Text(
            'Keine Aufgaben',
            style: TextStyle(fontSize: 20),
          ))
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 10),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return TodoWidget(todo: todo);
            });

    /* children: [
        for (final todo in todos)
          CheckboxListTile(
            value: todo.isDone,
            onChanged: (value) =>
                ref.read(todosProvider.notifier).toggle(todo.id),
            title: Text(todo.title),
          ),
      ], */
  }
}
