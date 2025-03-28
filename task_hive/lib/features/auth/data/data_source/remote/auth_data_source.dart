import '../../../domain/entity/user_info.dart';

abstract class AuthDataSource {
  Future<void> signUp(UserInfo userInfo);
  Future<void> signIn(UserInfo userInfo);
  Future<void> forgetPassword();
  Future<void> verifyOtp();
  Future<void> addUser(UserInfo userInfo);
  Future<Map<String, dynamic>> getUser();
}
