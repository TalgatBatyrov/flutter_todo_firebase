import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/todos_cubit/todos_cubit.dart';
import '../dialogs/app_info_dialog.dart';
import '../dialogs/delete_dialog.dart';
import '../models/todo.dart';
import 'delete_button.dart';
import 'package:share_plus/share_plus.dart';

class TodoPage extends StatelessWidget {
  final Todo todo;
  const TodoPage({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    final todosCubit = context.read<TodosCubit>();
    return InkWell(
      onDoubleTap: () async {
        Share.share(
          todo.title,
          subject: 'Todo',
        );

        // await Share.shareWithResult(todo.title, subject: 'Todo');

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => DetailTodo(todo: todo),
        //   ),
        // );
      },
      onLongPress: () {
        _editTitleTodo(
          context,
          todo,
          onPressed: (value) {
            todosCubit.editTitleTodo(
              id: todo.id,
              title: value,
            );
          },
          title: 'Изменить',
        );
      },
      child: Card(
        child: CheckboxListTile(
          value: todo.completed,
          onChanged: (value) {
            todosCubit.completedChanged(
              id: todo.id,
              isCompleted: value!,
            );
          },
          secondary: DeleteButton(
            onPressed: () => _onDelete(context, todo.id),
          ),
          title: Text(
            todo.title,
          ),
          subtitle: Row(
            children: [
              Text(
                DateFormat('dd/MM/yyyy hh:mm').format(todo.createdAt),
              ),
              IconButton(
                onPressed: () {
                  todosCubit.favoriteChanged(
                    id: todo.id,
                    isFavorite: !todo.isFavorite,
                  );
                },
                icon: Icon(
                  todo.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _onDelete(BuildContext context, String id) async {
  final todosCubit = context.read<TodosCubit>();
  final isConfirmed = await showDeleteDialog(context);
  if (isConfirmed != true) {
    return;
  }
  todosCubit.deleteTodo(id).onError(
        (error, stackTrace) => showAppInfo(
          context,
          error.toString(),
        ),
      );
}

Future<dynamic> _editTitleTodo(
  BuildContext context,
  Todo todo, {
  required String title,
  required Function(String) onPressed,
}) {
  final controller = TextEditingController(text: todo.title);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
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
              onPressed(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
