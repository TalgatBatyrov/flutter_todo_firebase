import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/services/todo_api.dart';

import '../../models/todo.dart';

class TodoCubit extends Cubit<Todo> {
  final Todo initial;
  final TodoApi _api;
  late final StreamSubscription _todoSubscription;

  TodoCubit(this.initial, this._api) : super(initial) {
    final todoPath = 'todos/${initial.id}';
    final todo = FirebaseFirestore.instance.doc(todoPath);
    _todoSubscription = todo.snapshots().listen(
          (event) => emit(Todo.fromJson(event)),
        );
  }

  @override
  Future<void> close() {
    _todoSubscription.cancel();
    return super.close();
  }

  // titile update
  Future<void> updateTitle(String title) async {
    await _api.editTitleTodo(
      id: initial.id,
      title: title,
    );
  }

  // completed update
  Future<void> updateCompleted(bool completed) async {
    await _api.completedChanged(
      id: initial.id,
      isCompleted: completed,
    );
  }

  // delete todo
  Future<void> delete() async {
    await _api.deleteTodo(initial.id);
  }
}
