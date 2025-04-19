import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_hive/core/services/auth_service/auth_service.dart';

import '../../logger/logger.dart';

class SupabaseImpl implements AuthService {
  late final SupabaseClient _client;

  @override
  Future<void> init() async {
    try {
      await dotenv.load(fileName: ".env");
      await Supabase.initialize(
        url: dotenv.env['SUPABASE_URL'] ?? 'No URL found',
        anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? 'No Anon Key found',
      );
      _client = Supabase.instance.client;
    } catch (e) {
      logger.e(e.toString());
    }
  }

  @override
  GoTrueClient getAuthClient() {
    return _client.auth;
  }

  @override
  SupabaseClient getSupabaseClient() {
    return _client;
  }
}
