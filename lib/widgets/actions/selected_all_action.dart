import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/todos_cubit/todos_cubit.dart';
import '../../blocs/todos_cubit/todos_state.dart';

class SelectedAllAction extends StatelessWidget {
  const SelectedAllAction({super.key});

  @override
  Widget build(BuildContext context) {
    final todosCubit = context.read<TodosCubit>();
    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        if (state is TodosLoaded) {
          final todos = state.todos;
          final completedTodos = state.completedTodos;

          return IconButton(
            onPressed: () {
              // select all todos
              todosCubit.selectAllTodos(todos.length != completedTodos.length);
            },
            icon: Icon(
              todos.length == completedTodos.length ? Icons.check_box : Icons.check_box_outline_blank,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
