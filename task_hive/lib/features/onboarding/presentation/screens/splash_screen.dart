import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../onboarding_cubit/onboarding_cubit.dart';
import '../../../../core/navigation/routes.dart';
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
      body: _buildBody(),
    );
  }

  Center _buildBody() {
    return Center(
      child: _bodyElements(),
    );
  }

  Column _bodyElements() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<OnboardingCubit, OnboardingState>(
          bloc: _onboardingCubit,
          builder: (context, state) {
            if (state is OnboardingLoaded) {
              bool onboardComplete = state.onboardComplete;

              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  if (!onboardComplete) {
                    context.go("/${MyRoutes.onboard1}");
                  } else {
                    if (state.isSignedIn) {
                      context.go(MyRoutes.profile);
                    } else {
                      context.go(MyRoutes.signInRoute);
                    }
                  }
                },
              );
            }

            if (state is OnboardingError) {
              return Center(child: Text(state.message));
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
    );
  }
}
