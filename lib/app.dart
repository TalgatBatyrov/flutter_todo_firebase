import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/theme_cubit/theme_cubit.dart';
import 'package:flutter_todo/services/todo_api.dart';
import 'package:flutter_todo/pages/home_page.dart';

import 'blocs/todos_cubit/todos_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => TodoApi(),
      child: Builder(builder: (context) {
        final api = context.read<TodoApi>();
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => TodosCubit(api),
            ),
            BlocProvider(
              create: (_) => ThemeCubit(),
            ),
          ],
          child: BlocBuilder<ThemeCubit, ThemeData>(
            builder: (context, theme) {
              return MaterialApp(
                theme: theme,
                home: const HomePage(),
                debugShowCheckedModeBanner: false,
              );
            },
          ),
        );
      }),
    );
  }
}
