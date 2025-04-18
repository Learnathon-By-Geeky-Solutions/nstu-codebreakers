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
      await supabaseClient.from('users').insert(userInfo.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
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
}
