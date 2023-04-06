import 'package:flutter/material.dart';

import '../models/todo.dart';

class DetailTodo extends StatelessWidget {
  final Todo todo;
  const DetailTodo({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(todo.id),
            Text(todo.title),
            Text(todo.createdAt.toString()),
          ],
        ),
      ),
    );
  }
}
