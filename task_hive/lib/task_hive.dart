import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hive/splash_screen.dart';

import 'core/base/cubit/base_cubit.dart';
import 'core/base/cubit/base_state.dart';
import 'core/di/di.dart';
import 'core/navigation/router_config.dart';
import 'core/theme/theme.dart';
import 'features/auth/presentation/screens/signin_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final theme = getIt<BaseCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseCubit, BaseState>(
      bloc: theme,
      builder: (context, state) {
        return MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeClass.lightTheme,
          darkTheme: ThemeClass.darkTheme,
          themeMode: state.themeMode,
          routerConfig: MyRouterConfig.router,
        );
      },
    );
  }
}
