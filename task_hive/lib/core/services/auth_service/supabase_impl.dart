import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_hive/core/services/auth_service/auth_service.dart';

import '../../logger/logger.dart';

class SupabaseImpl implements AuthService {
  @override
  Future<void> init() async {
    try {
      await dotenv.load(fileName: ".env");
      await Supabase.initialize(
        url: dotenv.env['APK_URL'] ?? 'No URL found',
        anonKey: dotenv.env['ANON_KEY'] ?? 'No Anon Key found',
      );
    } catch (e) {
      logger.e(e.toString());
    }
  }

  @override
  GoTrueClient getAuthClient() {
    return Supabase.instance.client.auth;
  }
}
