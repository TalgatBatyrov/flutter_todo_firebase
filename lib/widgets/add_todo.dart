import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/todos_cubit/todos_cubit.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final todosCubit = context.read<TodosCubit>();
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Add Todo'),
              content: TextField(
                controller: controller,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    todosCubit.createTodo(controller.text);
                    controller.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
