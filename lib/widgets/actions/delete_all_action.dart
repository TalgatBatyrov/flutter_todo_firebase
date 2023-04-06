import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/todos_cubit/todos_cubit.dart';

class DeleteAllAction extends StatelessWidget {
  const DeleteAllAction({super.key});

  @override
  Widget build(BuildContext context) {
    final todosCubit = context.read<TodosCubit>();
    return IconButton(
      onPressed: () {
        // are you sure
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Delete all todos?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    todosCubit.deleteAllTodos();
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(Icons.delete),
    );
  }
}
