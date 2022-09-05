// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marq_app/model/todo_model.dart';

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier()
      : super([
          Todo(/* createdTime: DateTime.now() ,*/ id: "", title: 'First Task'),
          /* Todo(
              createdTime: DateTime.now(),
              id: "",
              title: 'Second Task',
              description: "Hello") */
        ]);

  // Let's allow the UI to add todos.
  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  //Remove DELETE Todos
  void removeTodo(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  //another way to delete
  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
    ;
  }

  /* void undoDelete() => state = state.afterUndo(); */

  //Mark as isDone
  void toggle(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId) todo.copyWith(isDone: !todo.isDone) else todo,
    ];
  }

  //edit Todo Task
  void editTodo(
      {required String id, required String title, String? description}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            /* createdTime: DateTime.now(), */
            id: todo.id,
            isDone: todo.isDone,
            title: title,
            description: todo.description,
          )
        else
          todo,
    ];
  }
}

// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our TodosNotifier class.
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});

//COMPLETE Provider
enum Filter {
  all,
  isDone,
  uncompleted,
}

final todoListFilter = StateProvider((ref) => Filter.all);

final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todosProvider);

  switch (filter) {
    case Filter.all:
      return todos;
    case Filter.isDone:
      return todos.where((todo) => todo.isDone).toList();
    case Filter.uncompleted:
      return todos.where((todo) => !todo.isDone).toList();
  }
});
