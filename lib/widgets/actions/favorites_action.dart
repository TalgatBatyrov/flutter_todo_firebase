import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/todos_cubit/todos_cubit.dart';
import '../../blocs/todos_cubit/todos_state.dart';
import '../../pages/favorites.dart';

class FavoritesAction extends StatelessWidget {
  const FavoritesAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        if (state is TodosLoaded) {
          final favoriteTodos = state.favoriteTodos;
          return IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Favorites(),
                  ));
            },
            icon: Row(
              children: [
                Text(favoriteTodos.length.toString()),
                Icon(
                  favoriteTodos.length > 0 ? Icons.favorite : Icons.favorite_border,
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
