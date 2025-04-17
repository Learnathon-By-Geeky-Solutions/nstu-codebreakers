abstract class ProjectDataSource {
  Future<List<Map<String, dynamic>>> fetchProject(int userId);
  Future<void> addProject(Map<String, dynamic> project);
  Future<void> deleteProject(String id);
  Future<void> updateProject(Map<String, dynamic> project);
}
