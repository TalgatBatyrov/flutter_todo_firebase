
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/theme_cubit/theme_cubit.dart';

class ToggleThemeAction extends StatelessWidget {
  const ToggleThemeAction({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    return IconButton(
      onPressed: () {
        themeCubit.toggleTheme();
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: themeCubit.isLightTheme
            ? Icon(
                key: UniqueKey(),
                Icons.nightlight_round,
              )
            : Icon(
                key: UniqueKey(),
                Icons.sunny,
              ),
      ),
    );
  }
}
