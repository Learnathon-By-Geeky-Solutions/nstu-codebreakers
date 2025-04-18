import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/entity/user_entity.dart';

abstract class AuthRemote {
  Future<void> signUp(UserEntity userInfo);
  Future<AuthResponse> signIn(UserEntity userInfo);
  Future<void> forgetPassword(String email);
  Future<void> verifyOtp();
  Future<void> addUser(UserEntity userInfo);
  Future<Map<String, dynamic>> getUser(String? email);
}
