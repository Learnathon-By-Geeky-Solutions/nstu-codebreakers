import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/services/auth_service/auth_service.dart';
import '../../../../../core/di/di.dart';
import 'auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final authClient = getIt<AuthService>().getAuthClient();

  @override
  Future<void> forgetPassword() {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(Map<String, dynamic> input) async {
    print('dbg sign in $input');
    final res = await authClient.signInWithPassword(
      email: input['email'],
      password: input['password'],
    );

    print('dbg after sign in: ${res.user?.identities}');
  }

  @override
  Future<void> signUp(Map<String, dynamic> input) async {
    await authClient.signUp(
      email: input['email'],
      password: input['password'],
    );
  }

  @override
  Future<void> verifyOtp() {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }
}
