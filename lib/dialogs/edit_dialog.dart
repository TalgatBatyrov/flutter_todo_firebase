import 'package:flutter/material.dart';

import '../models/todo.dart';
import 'generic_dialog.dart';

Future<String> showEditDialog(
  BuildContext context,
  Todo todo,
) async {
  final controller = TextEditingController(text: todo.title);
  String value = '';
  return showGenericDialog<String>(
    context: context,
    content: StatefulBuilder(
      builder: (context, setState) {
        return TextField(
          controller: controller,
          onChanged: (value) {
            setState(() {
              value = value;
            });
          },
        );
      },
    ),
    title: 'Изменить',
    optionsBuilder: () => {
      'Отмена': todo.title,
      'Да': value,
    },
  ).then((value) => value ?? todo.title);
}
