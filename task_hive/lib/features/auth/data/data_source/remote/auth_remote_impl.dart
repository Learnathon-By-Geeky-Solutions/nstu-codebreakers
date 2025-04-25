import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/services/auth_service/auth_service.dart';
import '../../../../../core/di/di.dart';
import '../../../domain/entity/user_entity.dart';
import 'auth_remote.dart';

class AuthRemoteImpl implements AuthRemote {
  final SupabaseClient supabaseClient;
  final authClient = getIt<AuthService>().getAuthClient();

  AuthRemoteImpl({SupabaseClient? supabaseClient})
      : supabaseClient =
            supabaseClient ?? getIt<AuthService>().getSupabaseClient();

  @override
  Future<AuthResponse> signIn(UserEntity userInfo) async {
    return await authClient.signInWithPassword(
      email: userInfo.email ?? '',
      password: userInfo.password ?? '',
    );
  }

  @override
  Future<void> signUp(UserEntity userInfo) async {
    await authClient.signUp(
      email: userInfo.email ?? '',
      password: userInfo.password ?? '',
    );
  }

  @override
  Future<void> forgetPassword(String email) async {
    await authClient.resetPasswordForEmail(email);
  }

  @override
  Future<void> verifyOtp() {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }

  @override
  Future<void> addUser(UserEntity userInfo) async {
    try {
      // First check if user exists
      final existingUser = await supabaseClient
          .from('users')
          .select()
          .eq('id', userInfo.id.toString())
          .maybeSingle();
      // Only insert if user doesn't exist
      if (existingUser == null) {
        await supabaseClient.from('users').insert({
          'id': userInfo.id,
          'email': userInfo.email,
          'full_name': userInfo.name,
          'profile_picture': userInfo.profilePictureUrl,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });
      }
      // Else do nothing (user already exists)
    } catch (e) {
      // logger.e('Error in addUser: $e');
      throw Exception('Failed to add user: $e');
    }// Important: Specify the conflict column
  }

  @override
  Future<Map<String, dynamic>> getUser(String? email) async {
    try {
      if (email == null) {
        throw Exception('Email cannot be null');
      }
      final response = await supabaseClient
          .from('users')
          .select()
          .eq('email', email)
          .single();
      return response;
    } catch (e) {
      throw Exception('Error retrieving user data: ${e.toString()}');
    }
  }

  @override
  Future<AuthResponse> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
        serverClientId:
            '688864880472-65bh2k76mqijcjl0jh4d9snsgmoakf9a.apps.googleusercontent.com', // Only needed for Android
      );

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) throw const AuthException('Sign in cancelled');

      final googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw const AuthException('Missing Google auth tokens');
      }

      final response = await supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken!,
      );

      if (response.user == null) {
        throw const AuthException('Google sign-in failed');
      }

      return response;
    } catch (e) {
      throw AuthException(e.toString());
    }
  }
}
