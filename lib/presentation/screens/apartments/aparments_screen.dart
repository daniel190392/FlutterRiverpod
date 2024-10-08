import 'package:example_riverpod/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'widgets/card.dart';

import 'package:example_riverpod/presentation/providers/providers.dart';

class AparmentsScreen extends ConsumerStatefulWidget {
  static var name = 'aparments_screen';

  const AparmentsScreen({super.key});

  // @override
  // State<AparmentsScreen> createState() => _AparmentsScreenState();
  @override
  ConsumerState<AparmentsScreen> createState() => _AparmentsScreenState();
}

class _AparmentsScreenState extends ConsumerState<AparmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter'),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(aparmentsProvider.notifier).logout();
              if (context.mounted) {
                context.pushReplacementNamed(AuthenticationScreen.name);
              }
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return const ApartmentCard();
        },
      ),
    );
  }
}
