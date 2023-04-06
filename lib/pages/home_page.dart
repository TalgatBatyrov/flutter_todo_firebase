import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/todos_cubit/todos_cubit.dart';
import 'package:flutter_todo/blocs/todos_cubit/todos_state.dart';
import 'package:flutter_todo/widgets/actions/delete_all_action.dart';
import 'package:flutter_todo/widgets/actions/favorites_action.dart';
import 'package:flutter_todo/widgets/actions/selected_all_action.dart';
import 'package:flutter_todo/widgets/actions/todo_counts_action.dart';
import 'package:flutter_todo/widgets/actions/toggle_theme_action.dart';
import 'package:flutter_todo/widgets/loading_widget.dart';
import 'package:flutter_todo/widgets/todo_page.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  final editController = TextEditingController();
  var data = <dynamic>{};

  @override
  Widget build(BuildContext context) {
    final todosCubit = context.read<TodosCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          const FavoritesAction(),
          const SelectedAllAction(),
          const DeleteAllAction(),
          const TodoCountsAction(),
          const ToggleThemeAction(),
          BlocBuilder<TodosCubit, TodosState>(
            builder: (context, state) {
              if (state is TodosLoaded) {
                final todos = state.todos;
                return TextButton(
                    onPressed: () {
                      todos.forEachWithIndex((element, index) {
                        data.add('${index + 1}. ${element.title}\n'.toUpperCase());
                      });
                      Share.share(
                        data.join(''),
                        subject: 'Todo',
                      );
                    },
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ));
              }
              return const SizedBox();
            },
          )
        ],
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (state is TodosLoading) {
            return const LoadingWidget();
          }
          if (state is TodosError) {
            return ErrorWidget(state.message);
          }
          if (state is TodosLoaded) {
            final todos = state.todos;

            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return TodoPage(todo: todo);
              },
            );
          }
          return const LoadingWidget();
        },
      ),
      floatingActionButton: FloatingActionButton(
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
      ),
    );
  }
}

extension MapWithIndex<T> on List<T> {
  void forEachWithIndex(void Function(T element, int index) f) {
    var index = 0;
    for (final element in this) {
      f(element, index);
      index++;
    }
  }
}
