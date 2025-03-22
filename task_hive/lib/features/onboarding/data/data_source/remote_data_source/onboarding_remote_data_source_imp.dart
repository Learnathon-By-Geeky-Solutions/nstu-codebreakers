import 'onboarding_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OnboardingRemoteDataSourceImp implements OnboardingRemoteDataSource {
  @override
  Future<bool> checkSignedInStatus() async {
    final session = Supabase.instance.client.auth.currentSession;
    return session != null;
  }
}
