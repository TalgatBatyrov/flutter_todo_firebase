import 'package:flutter/material.dart';
import 'package:flutter_todo/widgets/todo_page.dart';

import '../models/todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;

  const TodoList({
    super.key,
    required this.todos,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoPage(todo: todo);
      },
    );
  }
}
