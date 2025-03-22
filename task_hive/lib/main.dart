import 'package:flutter/material.dart';
import 'core/database_service/remote/supabase_init.dart';
import 'core/di/di.dart';
import 'task_hive.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  getIt<SupabaseInit>().init();
  runApp(MyApp());
}
