import 'package:bytelogik_counter_app/core/constants/app_constants.dart';
import 'package:bytelogik_counter_app/features/auth/provider/auth_provider.dart';
import 'package:bytelogik_counter_app/features/counter/providers/counter_provider.dart';
import 'package:bytelogik_counter_app/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final counterNotifier = ref.read(counterProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.counterTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter: $counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: AppConstants.increment,
              onPressed: counterNotifier.increment,
              icon: Icons.add,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: AppConstants.decrement,
              onPressed: counterNotifier.decrement,
              icon: Icons.remove,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: AppConstants.reset,
              onPressed: counterNotifier.reset,
              icon: Icons.refresh,
            ),
          ],
        ),
      ),
    );
  }
}