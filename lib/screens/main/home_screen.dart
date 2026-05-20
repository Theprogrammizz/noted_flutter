import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_flutter/providers/auth/auth_provider.dart';
import 'package:noted_flutter/screens/auth/login_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
        actions: [
          IconButton(
            onPressed: authState.isLoading
                ? null
                : () async{
                    await ref.read(authProvider.notifier).signUserOut();
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    }
                  },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
