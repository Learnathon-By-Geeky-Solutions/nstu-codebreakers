abstract class ProfileDataSource {
  Future<Map<String, dynamic>> getProfileInfo(int userId);
  Future<Map<String, dynamic>> updateProfileInfo(
      Map<String, dynamic> profileInfo);
}
