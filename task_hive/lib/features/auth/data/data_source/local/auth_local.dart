abstract class AuthLocal {
  Future<String> getUserName();
  Future<String> getUserEmail();
  Future<String> getUserId();
  Future<void> saveUser(Map<String, dynamic> user);
}
