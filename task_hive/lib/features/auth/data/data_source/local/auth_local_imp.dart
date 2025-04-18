import '../../../../../core/di/di.dart';
import '../../../../../core/services/local/shared_preference_services.dart';
import 'auth_local.dart';

class AuthLocalImpl implements AuthLocal {
  @override
  Future<String> getUserEmail() async {
    final localAgent = getIt<SharedPreferenceService>();
    final userEmail = await localAgent.getString('email');
    return userEmail ?? 'No email found';
  }

  @override
  Future<String> getUserId() async {
    final localAgent = getIt<SharedPreferenceService>();
    final userId = await localAgent.getString('userId');
    return userId ?? 'No id found';
  }

  @override
  Future<String> getUserName() async {
    final localAgent = getIt<SharedPreferenceService>();
    final userName = await localAgent.getString('userName');
    return userName ?? 'No name found';
  }

  @override
  Future<void> saveUser(Map<String, dynamic> user) async {
    final localAgent = getIt<SharedPreferenceService>();
    await localAgent.clear();
    await localAgent.setString('userName', user['full_name']);
    await localAgent.setString('userEmail', user['email']);
    await localAgent.setInt('userId', user['id']);
  }
}
