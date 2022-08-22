import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marq_app/model/todo_model.dart';
import 'package:marq_app/provider/todo_provider.dart';
import 'package:marq_app/widget/todo_form_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: must_be_immutable
class AddTodoDialog extends HookConsumerWidget {
  final _formKey = GlobalKey<
      FormState>(); //Validate the fields in the Dialog (Title/Überschrift)

  //Fields inside the Dialog
  String title = " ";
  String description = " ";

  AddTodoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = useState<String>("");
    final description = useState<String>("");

    void addTask() {
      //calls the todo Form validator of the title --> that makes sure field is not Empty (title!.isEmpty)
      if (_formKey.currentState!.validate()) {
        final todo = Todo(
            createdTime: DateTime.now(),
            id: DateTime.now().toString(),
            title: title.value,
            description: description.value);

        ref.read(todosProvider.notifier).addTodo(todo);

        Navigator.pop(context); //"pop" the dialog from route --> close it
      }
    }

    return AlertDialog(
        content: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Aufgabe hinzufügen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),

            const SizedBox(height: 1), //Space inbetween

            TodoFormWidget(
              //Callbacks
              onChangedTitle: (titleInput) {
                title.value = titleInput;
              },

              onChangedDescription: (descriptionInput) {
                description.value = descriptionInput;
              },
              onSaveTodo: (() => addTask()),
            )
          ],
        ),
      ),
    ));
  }
}
