import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marq_app/model/todo_model.dart';
import 'package:marq_app/provider/todo_provider.dart';
import 'package:marq_app/widget/todo_form_widget.dart';

class AddTodoDialogWidget extends StatefulWidget {
  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<
      FormState>(); //Validate the fields in the Dialog (Title/Überschrift)

  //Fields inside the Dialog
  String title = " ";
  String description = " ";

  @override
  Widget build(BuildContext context) => AlertDialog(
          content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Aufgabe hinzufügen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 5), //Space inbetween
            TodoFormWidget(
              //Callbacks
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSaveTodo: (value) {} /* addTodo */,
            )
          ],
        ),
      ));

  void addTodo() {
    //calls the todo Form validator of the title --> that makes sure field is not Empty (title!.isEmpty)
    final isValid = _formKey.currentState?.validate();

    if (isValid!) {
      return; //User will get error message
    } else {
      final todo = Todo(
          createdTime: DateTime.now(),
          id: DateTime.now().toString(),
          title: title,
          description: description);

      Navigator.of(context).pop(); //"pop" the dialog from route --> close it

    }
  }
}
