import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/services/auth_service/auth_service.dart';
import '../../../../../core/di/di.dart';
import '../../../domain/entity/user_info.dart';
import 'auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final SupabaseClient supabaseClient;
  final authClient = getIt<AuthService>().getAuthClient();
  AuthDataSourceImpl({SupabaseClient? supabaseClient})
      : supabaseClient =
            supabaseClient ?? getIt<AuthService>().getSupabaseClient();

  @override
  Future<void> forgetPassword() {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(UserInfo userInfo) async {
    final res = await authClient.signInWithPassword(
      email: userInfo.email ?? '',
      password: userInfo.password ?? '',
    );
  }

  @override
  Future<void> signUp(UserInfo userInfo) async {
    await authClient.signUp(
      email: userInfo.email ?? '',
      password: userInfo.password ?? '',
    );
  }

  @override
  Future<void> verifyOtp() {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }

  @override
  Future<void> addUser(UserInfo userInfo) async {
    try {
      await supabaseClient.from('users').insert(userInfo.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
