import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_hive/features/onboarding/presentation/onboarding_cubit/onboarding_cubit.dart';
import 'dart:async';

import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/database_service/local/shared_preference_service.dart';
import '../../../../core/di/di.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _onboardingCubit = getIt<OnboardingCubit>();

  @override
  void initState() {
    super.initState();
    _onboardingCubit.checkOnboardingStatus();
  }

  @override
  void dispose() {
    _onboardingCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<OnboardingCubit, OnboardingState>(
              bloc: _onboardingCubit,
              builder: (context, state) {
                print('dbg state: ${state.runtimeType}');

                if (state is OnboardingLoaded) {
                  bool isFirstTime = state.isFirstTime;

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (isFirstTime) {
                      print('dbg here before go onboard 1');
                      context.go("/${MyRoutes.onboard1}");
                    } else {
                      if (state.isSignedIn) {
                        // context.go("/${MyRoutes.home}");
                      } else {
                        context.go("/${MyRoutes.signInRoute}");
                      }
                    }
                  });
                }

                if (state is OnboardingError) {
                  return Center(child: Text("Error: ${state.message}"));
                }

                return const CircularProgressIndicator();
              },
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
