import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

import 'package:task_hive/core/navigation/router_config.dart';
import 'package:task_hive/core/navigation/routes.dart';
import 'package:task_hive/core/theme/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      context.go("/${MyRoutes.onboard1}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: AppColors.brand,
            ),
            Image.asset(
              'assets/images/logo.png',
              height: 150,
              width: 150,
            ),
          ],
        ),
      ),
    );
  }
}
