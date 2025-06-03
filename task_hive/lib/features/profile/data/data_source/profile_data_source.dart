abstract class ProfileDataSource {
  Future<Map<String, dynamic>> getProfileInfo(int userId);
  Future<String> uploadProfileImage(String filePath);
  Future<Map<String, dynamic>> updateProfileInfo(
      Map<String, dynamic> profileInfo);
}
