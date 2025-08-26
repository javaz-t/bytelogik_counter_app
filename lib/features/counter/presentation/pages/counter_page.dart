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
          _confirmLogout(context, ref);
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

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
  final shouldLogout = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          Row(
            children: [
  Expanded(
    child: TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel
              },
              child: const Text("No"),
            ),
  ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm
              },
              child: const Text("Yes"),
            ),
          ),
            ],
          )
        
        ],
      );
    },
  );

  if (shouldLogout == true) {
    await ref.read(authControllerProvider.notifier).signOut();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Logged out successfully ✅"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
}