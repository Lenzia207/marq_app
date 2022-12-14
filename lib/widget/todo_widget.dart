import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:marq_app/model/todo_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marq_app/provider/todo_provider.dart';

import '../page/edit_todo_page.dart';

class TodoWidget extends HookConsumerWidget {
  //For the Todo make use of the Title & Description
  final Todo todo;

  const TodoWidget({
    required this.todo,
    Key? key,
  }) : super(key: key);

  void deleteTodo(BuildContext context, WidgetRef ref) {
    ref.read(todosProvider.notifier).removeTodo(todo.id);

    final snackBar = SnackBar(
      duration: const Duration(seconds: 5),
      content: const Text("Wird gelöscht"),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () => ref.read(todosProvider.notifier).remove(todo),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void editTodo(BuildContext context, WidgetRef ref) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EditTodoPage(todo: todo)),
    );
  }

  void checkTodo(BuildContext context, WidgetRef ref) {
    ref.read(todosProvider.notifier).toggle(todo.id);

    //if isDone == true --> move to complete Site
    if (todo.isDone == true) {}
  }

  @override
  //ClipRRect() --> For Border Radius Container/Box/Widget
  Widget build(BuildContext context, WidgetRef ref) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          actionPane: const SlidableDrawerActionPane(),
          key: Key(todo.id),

          //Create EDIT
          actions: [
            IconSlideAction(
              icon: Icons.edit,
              caption: 'Edit',
              foregroundColor: Colors.white,
              color: Colors.green,
              onTap: () => editTodo(context, ref),
            ),
          ],

          //Create DELETE
          secondaryActions: [
            IconSlideAction(
              key: const Key("deleteBtn"),
              icon: Icons.delete,
              caption: 'Delete',
              foregroundColor: Colors.white,
              color: Colors.red,
              onTap: () => deleteTodo(context, ref),
            ),
          ],
          child: buildTodo(context, ref),
        ),
      );

  Widget buildTodo(BuildContext context, WidgetRef ref) {
    //final todos = ref.watch(filteredTodoProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Card(
        elevation: 0,
        child: Row(
          children: [
            //for (final todo in todos)
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: todo.isDone,
              onChanged: (value) =>
                  ref.read(todosProvider.notifier).toggle(todo.id),
            ),

            const SizedBox(width: 20),

            //if there would be a description it can optinally expand to read description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TITLE
                  Text(
                    todo.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22),
                  ),

                  //If there is a DESCRIPTION
                  if (todo.description.isNotEmpty)
                    Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          todo.description,
                          style: const TextStyle(fontSize: 20, height: 1.5),
                        ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
