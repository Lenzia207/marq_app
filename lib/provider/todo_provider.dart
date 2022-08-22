// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marq_app/model/todo_model.dart';

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier()
      : super([
          Todo(createdTime: DateTime.now(), id: "", title: 'First Task'),
          Todo(createdTime: DateTime.now(), id: "", title: 'Second Task')
        ]);

  // Let's allow the UI to add todos.
  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  //Remove Todos
  void removeTodo(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  //Mark as isDone
  void toggle(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId) todo.copyWith(isDone: !todo.isDone) else todo,
    ];
  }

  void updateTodo(String todoId) {}
}

// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our TodosNotifier class.
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});
