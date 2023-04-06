import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final void Function()? onPressed;

  const DeleteButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width < 600
        ? IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.delete, color: Colors.red),
          )
        : TextButton(
            onPressed: onPressed,
            child: const Text(
              'Удалить',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          );
  }
}
