import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OnboardinApi {
  final _supabase = Supabase.instance.client;

  Future<AuthResponse> googleSignIn() async {
    final webClientId = dotenv.env['WEB_CLIENT_ID']!;
    final iosClientId = dotenv.env['IOS_CLIENT_ID']!;

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return _supabase.auth
        .signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    )
        .onError((error, stackTrace) {
      return AuthResponse();
    });
  }
}
