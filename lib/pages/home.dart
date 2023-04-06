import 'package:flutter/material.dart';
import 'package:flutter_todo/widgets/app_bar_actions/delete_all_action.dart';
import 'package:flutter_todo/widgets/body.dart';
import '../widgets/actions/favorites_action.dart';
import '../widgets/actions/selected_all_action.dart';
import '../widgets/actions/share_action.dart';
import '../widgets/actions/todo_counts_action.dart';
import '../widgets/actions/toggle_theme_action.dart';
import '../widgets/add_todo.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: const [
          FavoritesAction(),
          SelectedAllAction(),
          DeleteAllAction(),
          TodoCountsAction(),
          ToggleThemeAction(),
          ShareAction(),
        ],
      ),
      body: const Body(),
      floatingActionButton: const AddTodo(),
    );
  }
}
