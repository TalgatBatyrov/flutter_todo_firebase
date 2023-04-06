import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/widgets/todo_list.dart';
import '../blocs/todos_cubit/todos_cubit.dart';
import '../blocs/todos_cubit/todos_state.dart';
import 'loading_widget.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        if (state is TodosLoading) {
          return const LoadingWidget();
        }
        if (state is TodosError) {
          return ErrorWidget(state.message);
        }
        if (state is TodosLoaded) {
          final todos = state.todos;
          return TodoList(todos: todos);
        }
        return const LoadingWidget();
      },
    );
  }
}
