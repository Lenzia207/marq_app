import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:marq_app/widget/todo_widget.dart';
import 'package:marq_app/model/todo_model.dart';
import 'package:marq_app/provider/todo_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marq_app/widget/shimmer_widget.dart';
import 'dart:async';

class TodoListWidget extends HookConsumerWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todosProvider);
    final filter = ref.watch(todoListFilter);
    bool isLoading = true;

    Future.delayed(const Duration(seconds: 3), () {
      useState(() {
        isLoading = false;
      });
    });

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
            itemCount: todos.length,
            itemBuilder: (context, index) {
              if (isLoading == true) {
                return buildTodoShimmer();
              } else {
                final todo = todos[index];
                return TodoWidget(todo: todo);
              }
            },
          );
  }

  Widget buildTodoShimmer() => const ListTile(
        leading: ShimmerWidget.rectangular(
          height: 20,
          width: 20,
        ),
        title: ShimmerWidget.rectangular(
          height: 22,
        ),
        subtitle: ShimmerWidget.rectangular(height: 16),
      );
}
