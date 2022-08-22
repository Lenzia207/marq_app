import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:marq_app/model/todo_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marq_app/provider/todo_provider.dart';

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
      duration: Duration(seconds: 20),
      content: Text("Wird gelöscht"),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  //ClipRRect() --> For Border Radius Container/Box/Widget
  Widget build(BuildContext context, WidgetRef ref) => ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        actionPane: const SlidableDrawerActionPane(),
        key: Key(todo.id),

        //Create Edit
        actions: [
          IconSlideAction(
            icon: Icons.edit,
            caption: 'Edit',
            foregroundColor: Colors.white,
            color: Colors.green,
            onTap: () {},
          ),
        ],

        secondaryActions: [
          IconSlideAction(
            icon: Icons.delete,
            caption: 'Delete',
            foregroundColor: Colors.white,
            color: Colors.red,
            onTap: () => deleteTodo(context, ref),
          )
        ],
        child: buildTodo(context),
      ));

  Widget buildTodo(BuildContext context) => Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        children: [
          Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: todo.isDone,
              onChanged: (value) {}),

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
          ))
        ],
      ));
}
