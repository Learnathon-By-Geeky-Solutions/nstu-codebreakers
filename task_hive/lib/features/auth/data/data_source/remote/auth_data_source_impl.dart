import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/services/auth_service/auth_service.dart';
import '../../../../../core/di/di.dart';
import '../../../domain/entity/user_entity.dart';
import 'auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final SupabaseClient supabaseClient;
  final authClient = getIt<AuthService>().getAuthClient();
  AuthDataSourceImpl({SupabaseClient? supabaseClient})
      : supabaseClient =
            supabaseClient ?? getIt<AuthService>().getSupabaseClient();

  @override
  Future<void> signIn(UserEntity userInfo) async {
    await authClient.signInWithPassword(
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
  Future<Map<String, dynamic>> getUser() async {
    final email = supabaseClient.auth.currentUser?.email;
    if (email == null) {
      throw Exception(
          'Current user email not found. User may not be authenticated.');
    }
    try {
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
