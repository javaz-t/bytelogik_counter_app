import 'package:bytelogik_counter_app/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
 import 'features/auth/presentation/pages/login_page.dart';
import 'features/counter/presentation/pages/counter_page.dart';
import 'shared/widgets/loading_widget.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter App',
      theme: AppTheme.lightTheme,
      home: Consumer(
        builder: (context, ref, child) {
          final authState = ref.watch(authStateProvider);
          
          return authState.when(
            data: (user) {
              if (user != null) {
                return const CounterPage();
              }
              return const LoginPage();
            },
            loading: () => const LoadingWidget(),
            error: (error, stack) => Scaffold(
              body: Center(
                child: Text('Error: $error'),
              ),
            ),
          );
        },
      ),
    );
  }
}