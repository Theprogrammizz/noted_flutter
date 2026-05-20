import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_flutter/providers/auth/auth_notifier.dart';
import 'package:noted_flutter/services/auth_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authServiceProvider = Provider<AuthServices>((ref) {
  return AuthServices();
});

final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(
  AuthNotifier.new,
);
