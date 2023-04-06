import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/todos_cubit/todos_state.dart';
import '../../models/todo.dart';
import '../../services/todo_api.dart';

class TodosCubit extends Cubit<TodosState> {
  final TodoApi _api;
  late final StreamSubscription _todosSubscription;

  TodosCubit(this._api) : super(TodosLoading()) {
    _todosSubscription = _api.todosCollection.orderBy('createdAt').snapshots().listen(
      (snapshot) {
        final todos = snapshot.docs.map((doc) => Todo.fromJson(doc)).toList();
        emit(TodosLoaded(todos));
      },
    );
  }

  Future<void> createTodo(String title) async {
    try {
      final isExist = await _api.createTodo(title);
      if (!isExist) {
        emit(TodosError('Todo already exists'));
      }
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _api.deleteTodo(id);
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  Future<void> completedChanged({required String id, required bool isCompleted}) async {
    try {
      await _api.completedChanged(id: id, isCompleted: isCompleted);
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  Future<void> editTitleTodo({required String id, required String title}) async {
    try {
      await _api.editTitleTodo(id: id, title: title);
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  Future<void> deleteAllTodos() async {
    try {
      await _api.deleteAllTodos();
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  Future<void> selectAllTodos(bool select) async {
    try {
      await _api.selectAllTodos(select);
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  // fetch favorite todos

  Future<void> fetchFavoriteTodos() async {
    try {
      final favorites = await _api.fetchFavoriteTodos();
      emit(TodosLoaded(favorites));
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  Future<void> favoriteChanged({required String id, required bool isFavorite}) async {
    try {
      await _api.favoriteChanged(id: id, isFavorite: isFavorite);
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _todosSubscription.cancel();
    return super.close();
  }
}
