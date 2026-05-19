import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  final supabase = Supabase.instance.client;
  final GoogleSignIn signin = GoogleSignIn.instance;

  Future<User?> userLogin(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.user;
  }

  Future<User?> userSignup(String email, String password) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );
    return response.user;
  }

  Future<User?> googleSignin() async {
    await signin.initialize(
      serverClientId: dotenv.env['WEB_CLIENT'],
      clientId: dotenv.env['ANDROID_CLIENT'],
    );

    final GoogleSignInAccount account = await signin.authenticate();

    final idToken = account.authentication.idToken ?? '';
    final auth =
        await account.authorizationClient.authorizationForScopes([
          'email',
          'profile',
        ]) ??
        await account.authorizationClient.authorizeScopes(['email', 'profile']);

    final response = await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: auth.accessToken,
    );

    return response.user;
  }

  Future<void> forgotPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }
}
