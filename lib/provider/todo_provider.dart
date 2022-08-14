import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:marq_app/model/todo_model.dart';

class TodosNotifier extends ChangeNotifier {
  final todos = <Todo>[
    Todo(createdTime: DateTime.now(), id: "", title: 'First Task'),
    Todo(createdTime: DateTime.now(), id: "", title: 'Second Task'),
    Todo(
        createdTime: DateTime.now(),
        id: "",
        title: 'Third Task',
        description: '''-Thing1
    Thing 2
    - Thing3 '''),
  ];

  // Let's allow the UI to add todos.
  void addTodo(Todo todo) {
    todos.add(todo);
    notifyListeners();
  }

  //Remove Todos
  void removeTodo(String todoId) {
    todos.remove(todos.firstWhere((element) => (element.id == todoId)));
    notifyListeners();
  }

  //Mark as isDone
  void toggle(String todoId) {
    for (final todo in todos) {
      if (todo.id == todoId) {
        todo.isDone = !todo.isDone;
        notifyListeners();
      }
    }
  }
}

// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our TodosNotifier class.
final todosProvider = ChangeNotifierProvider<TodosNotifier>((ref) {
  return TodosNotifier();
});
