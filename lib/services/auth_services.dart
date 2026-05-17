import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  final supabase = Supabase.instance.client;
  final GoogleSignIn signin = GoogleSignIn.instance;

  void userLogin(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void userSignup(String email, String password) async {
    try {
      await supabase.auth.signUp(email: email, password: password);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void googleSignin() async {
    try {
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
          await account.authorizationClient.authorizeScopes([
            'email',
            'profile',
          ]);

        await supabase.auth.signInWithIdToken(provider: OAuthProvider.google, idToken: idToken, accessToken: auth.accessToken);
        
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
