import 'package:flutter/material.dart';
import 'package:marq_app/widget/todo_widget.dart';
import 'package:marq_app/model/todo_model.dart';
import 'package:marq_app/provider/todo_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoListWidget extends HookConsumerWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todosProvider);
    final filter = ref.watch(filterProvider);
    //inspect(todos);

    //Render the todos in a scrollable list view --> ListView()
    return todos.isEmpty
        ? const Center(
            child: Text(
            'Keine Aufgaben',
            style: TextStyle(fontSize: 20),
          ))
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 5),
            //onTap: () => ref.read(filterProvider.notifier).state = Filter.uncompleted,
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return TodoWidget(todo: todo);
            },
          );
  }
}
