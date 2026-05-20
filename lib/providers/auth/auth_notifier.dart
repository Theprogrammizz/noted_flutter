import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noted_flutter/providers/auth/auth_provider.dart';
import 'package:noted_flutter/services/auth_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthNotifier extends AsyncNotifier<User?> {
  late final AuthServices _services;
  @override
  Future<User?> build() async {
    _services = ref.watch(authServiceProvider);
    return null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await _services.userLogin(email, password);
    });
  }

  Future<void> signup(String email, String password) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await _services.userSignup(email, password);
    });
  }

  Future<void> googleSignIn() async{
    final user = await _services.googleSignin();
    state =  AsyncData(user);
  }

  Future<void> forgotPassword(String email) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await _services.forgotPassword(email);
      return null;
    });
  }
}
