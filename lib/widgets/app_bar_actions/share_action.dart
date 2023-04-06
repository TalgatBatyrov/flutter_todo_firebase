
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/extensions/extensions.dart';
import 'package:share_plus/share_plus.dart';
import '../../blocs/todos_cubit/todos_cubit.dart';
import '../../blocs/todos_cubit/todos_state.dart';

class ShareAction extends StatelessWidget {
  const ShareAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        if (state is TodosLoaded) {
          final todos = state.todos;
          final data = [];
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
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
