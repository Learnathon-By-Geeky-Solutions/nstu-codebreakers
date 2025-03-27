abstract class AuthDataSource {
  Future<void> signUp(Map<String, dynamic> input);
  Future<void> signIn(Map<String, dynamic> input);
  Future<void> forgetPassword();
  Future<void> verifyOtp();
}
