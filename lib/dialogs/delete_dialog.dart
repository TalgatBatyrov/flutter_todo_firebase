import 'package:flutter/cupertino.dart';

import 'generic_dialog.dart';

Future<bool> showDeleteDialog(
  BuildContext context,
) async {
  return showGenericDialog<bool>(
    context: context,
    content: const Text('Вы действительно хотите удалить?'),
    title: 'Удалить',
    optionsBuilder: () => {
      'Отмена': false,
      'Да': true,
    },
  ).then((value) => value ?? false);
}
