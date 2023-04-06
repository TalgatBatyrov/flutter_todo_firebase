import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/todos_cubit/todos_cubit.dart';
import 'package:flutter_todo/blocs/todos_cubit/todos_state.dart';

import '../widgets/loading_widget.dart';
import '../widgets/todo_page.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        if (state is TodosLoading) {
          return const LoadingWidget();
        }
        if (state is TodosLoaded) {
          final todos = state.favoriteTodos;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Favorites'),
            ),
            body: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return TodoPage(todo: todo);
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
