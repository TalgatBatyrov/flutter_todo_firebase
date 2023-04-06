import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/todo_cubit/todo_cubit.dart';
import '../models/todo.dart';
import '../services/todo_api.dart';

class Detail extends StatelessWidget {
  final Todo todo;
  const Detail({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final api = context.read<TodoApi>();
    return BlocProvider(
      create: (_) => TodoCubit(initial: todo, api),
      child: BlocBuilder<TodoCubit, Todo>(
        builder: (context, todo) {
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
        },
      ),
    );
  }
}
