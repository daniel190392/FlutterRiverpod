import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorModal extends StatefulWidget {
  const ErrorModal(this.message, {super.key});

  final String message;

  @override
  State<ErrorModal> createState() => _ErrorModalState();
}

class _ErrorModalState extends State<ErrorModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Error',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      content: Text(
        widget.message,
        style: const TextStyle(
          color: Colors.red,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => context.pop(),
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
