import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthService {
  Future<void> init();
  GoTrueClient getAuthClient();
  SupabaseClient getSupabaseClient();
}
