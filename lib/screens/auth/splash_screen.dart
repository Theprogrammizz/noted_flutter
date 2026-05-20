import 'package:flutter/material.dart';
import 'package:noted_flutter/screens/auth/login_screen.dart';
import 'package:noted_flutter/screens/main/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final supabase = Supabase.instance.client;

  void getScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (supabase.auth.currentSession == null) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    } else {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: FlutterLogo(size: 100)));
  }
}
