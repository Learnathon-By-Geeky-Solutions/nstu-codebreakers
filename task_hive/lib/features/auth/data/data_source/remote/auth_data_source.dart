import '../../../domain/entity/user_entity.dart';

abstract class AuthDataSource {
  Future<void> signUp(UserEntity userInfo);
  Future<void> signIn(UserEntity userInfo);
  Future<void> forgetPassword(String email);
  Future<void> verifyOtp();
  Future<void> addUser(UserEntity userInfo);
  Future<Map<String, dynamic>> getUser();
}
