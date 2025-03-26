import 'package:flutter/material.dart';
import 'package:task_hive/core/services/auth_service/auth_service.dart';

import 'core/services/auth_service/supabase_impl.dart';
import 'core/di/di.dart';
import 'core/logger/logger.dart';
import 'task_hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    setupLocator();
    await getIt<AuthService>().init();
  } catch (e, s) {
    logger.e(e.toString());
    logger.e(s.toString());
  }

  runApp(MyApp());
}
