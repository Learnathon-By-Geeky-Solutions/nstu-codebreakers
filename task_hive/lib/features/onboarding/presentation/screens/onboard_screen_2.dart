import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/app_extension.dart';
import '../../../../core/di/di.dart';
import '../../../../core/navigation/routes.dart';
import '../onboarding_cubit/onboarding_cubit.dart';

class OnboardScreen2 extends StatelessWidget {
  OnboardScreen2({super.key});
  final _onboardingCubit = getIt<OnboardingCubit>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _topElements(context, colorTheme),
              _midElements(textTheme),
              _bottomElements(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding _bottomElements(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {
          context.go(
              "/${MyRoutes.onboard1}/${MyRoutes.onboard2}/${MyRoutes.onboard3}");
        },
        child: const Text('Next'),
      ),
    );
  }

  SizedBox _midElements(TextTheme textTheme) {
    return SizedBox(
      child: Column(
        children: [
          Image.asset('assets/onboarding/onboard2.png'),
          const SizedBox(height: 20),
          Text(
            'Increase Work Effectiveness',
            style: textTheme.textBaseMedium,
          ),
          const SizedBox(height: 20),
          Text(
            'Time management and the determination of more important tasks will give your job statistics better and always improve',
            style: textTheme.textSmRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Row _topElements(BuildContext context, ColorScheme colorTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              _dot(false, colorTheme.primary),
              const SizedBox(width: 10),
              _dot(true, colorTheme.primary),
              const SizedBox(width: 10),
              _dot(false, colorTheme.primary),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            _onboardingCubit.setOnboardingCompleted();
            context.go(MyRoutes.signInRoute);
          },
          child: BlocConsumer<OnboardingCubit, OnboardingState>(
            bloc: _onboardingCubit,
            listener: (context, state) {
              if (state is OnboardingError) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                });
              }
            },
            builder: (context, state) {
              return const Text('Skip');
            },
          ),
        ),
      ],
    );
  }

  Container _dot(bool isActive, Color primaryColor) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: (isActive) ? primaryColor : primaryColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
    );
  }
}
