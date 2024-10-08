import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/providers.dart';
import '../../screens.dart';

class OtpModal extends ConsumerStatefulWidget {
  final String? deliveryDestination;

  const OtpModal(this.deliveryDestination, {super.key});

  @override
  ConsumerState<OtpModal> createState() => _OtpModalState();
}

class _OtpModalState extends ConsumerState<OtpModal> {
  final textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('OTP',
          style: TextStyle(
            color: Colors.red,
          )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'A confirmation code has been sent to ${widget.deliveryDestination}, please check your email',
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
          TextField(
            controller: textFieldController,
            decoration: const InputDecoration(
              hintText: 'put your code',
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => context.pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            await ref
                .read(authenticationProvider.notifier)
                .confirmationCode(textFieldController.text);
            if (context.mounted) {
              context.pop();
              context.pushReplacementNamed(AparmentsScreen.name);
            }
          },
          child: const Text('Send'),
        ),
      ],
    );
  }
}
