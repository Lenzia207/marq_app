import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:marq_app/provider/todo_provider.dart';
import 'package:marq_app/widget/todo_form_widget.dart';
import 'package:marq_app/model/todo_model.dart';

// ignore: must_be_immutable
class EditTodoPage extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;

  final Todo todo;

  EditTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();
    final description = useState<String>("");
    final text = useState<String>("");

    void saveTodo() {
      if (_formKey.currentState!.validate()) {
        Navigator.pop(context); //"pop" the dialog from route --> close it
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref.read(todosProvider.notifier).removeTodo(todo.id);

              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: TodoFormWidget(
            onChangedTitle: (titleInput) {
              if (titleInput == true) {
                textEditingController.text = todo.title;
              } else {
                ref.read(todosProvider.notifier).editTodo(
                      id: todo.id,
                      title: textEditingController.text,
                    );
              }
            },
            onChangedDescription: (descriptionInput) {
              if (descriptionInput == true) {
                textEditingController.text = todo.description;
              } else {
                ref.read(todosProvider.notifier).editTodo(
                      id: todo.id,
                      description: textEditingController.text,
                    );
              }
            },
            onSaveTodo: () => saveTodo(),
          ),
        ),
      ),
    );
  }
}
