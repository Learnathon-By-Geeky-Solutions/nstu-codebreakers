abstract class AuthDataSource {
  Future<void> signUp(Map<String, dynamic> input);
  Future<void> signIn();
  Future<void> forgetPassword();
  Future<void> verifyOtp();
}
