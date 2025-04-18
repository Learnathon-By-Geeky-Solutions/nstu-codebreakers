import '../../../../../core/di/di.dart';
import '../../../../../core/services/local/shared_preference_services.dart';
import 'home_local.dart';

class HomeLocalImpl implements HomeLocal {
  @override
  Future<int> getUserId() async {
    final localAgent = getIt<SharedPreferenceService>();
    final id = await localAgent.getInt('userId');
    return id ?? 0;
  }
}
