import 'package:flutter/material.dart';
import 'core/database_service/remote/supabase_init.dart';
import 'core/di/di.dart';
import 'core/logger/logger.dart';
import 'task_hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    setupLocator();
    await getIt<SupabaseInit>().init();
  } catch (e) {
    log.e(e.toString());
  }
  runApp(MyApp());
}
