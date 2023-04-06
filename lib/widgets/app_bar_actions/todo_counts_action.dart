
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/todos_cubit/todos_cubit.dart';
import '../../blocs/todos_cubit/todos_state.dart';

class TodoCountsAction extends StatelessWidget {
  const TodoCountsAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        if (state is TodosLoaded) {
          final todos = state.todos;

          return Center(
            child: Text(
              '${state.completedTodos.length}/${todos.length}',
              style: const TextStyle(fontSize: 18),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
