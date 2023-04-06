import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/services/todo_api.dart';
import '../../models/todo.dart';

class TodoCubit extends Cubit<Todo> {
  final Todo initial;
  final TodoApi _api;
  late final StreamSubscription _todoSubscription;

  TodoCubit(this._api, {required this.initial}) : super(initial) {
    final todoPath = 'todos/${initial.id}';
    final todo = FirebaseFirestore.instance.doc(todoPath);
    _todoSubscription = todo.snapshots().listen(
      (event) {
        final todo = Todo.fromJson(event);
        emit(todo);
      },
    );
  }

  @override
  Future<void> close() {
    _todoSubscription.cancel();
    return super.close();
  }

  Future<void> updateTitle(String title) async {
    await _api.editTitleTodo(
      id: initial.id,
      title: title,
    );
  }

  Future<void> updateCompleted(bool completed) async {
    await _api.completedChanged(
      id: initial.id,
      isCompleted: completed,
    );
  }

  Future<void> delete() async {
    await _api.deleteTodo(initial.id);
  }
}
