import '../../models/todo.dart';

abstract class TodosState {}

class TodosLoading extends TodosState {}

class TodosLoaded extends TodosState {
  final List<Todo> todos;

  get completedTodos => todos.where((todo) => todo.completed).toList();

  get favoriteTodos => todos.where((todo) => todo.isFavorite).toList();

  TodosLoaded(this.todos);
}

class TodosError extends TodosState {
  final String message;

  TodosError(this.message);
}
