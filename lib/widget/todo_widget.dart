import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:marq_app/model/todo_model.dart';

class TodoWidget extends StatelessWidget {
  //For the Todo make use of the Title & Description
  final Todo todo;

  const TodoWidget({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  //ClipRRect() --> For Border Radius Container/Box/Widget
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        child: buildTodo(context),
        actionPane: SlidableDrawerActionPane(),
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
            onTap: () {},
          )
        ],
      ));

  Widget buildTodo(BuildContext context) => Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        children: [
          Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: todo.isDone,
              onChanged: (_) {}),

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
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                      todo.description,
                      style: TextStyle(fontSize: 20, height: 1.5),
                    ))
            ],
          ))
        ],
      ));
}
