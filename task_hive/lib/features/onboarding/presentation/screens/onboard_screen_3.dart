import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/app_extension.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/di/di.dart';
import '../../../../core/navigation/routes.dart';
import '../onboarding_cubit/onboarding_cubit.dart';

class OnboardScreen3 extends StatelessWidget {
  OnboardScreen3({super.key});
  final _onboardingCubit = getIt<OnboardingCubit>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _topElements(context),
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
          context.go(MyRoutes.signInRoute);
        },
        child: const Text('Next'),
      ),
    );
  }

  SizedBox _midElements(TextTheme textTheme) {
    return SizedBox(
      child: Column(
        children: [
          Image.asset('assets/onboarding/onboard3.png'),
          const SizedBox(height: 20),
          Text(
            'Reminder Notification',
            style: textTheme.textBaseMedium,
          ),
          const SizedBox(height: 20),
          Text(
            'The advantage of this application is that it also provides reminders for you so you don\'t forget to keep doing your assignments well and according to the time you have set',
            style: textTheme.textSmRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Row _topElements(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              _dot(false),
              const SizedBox(width: 10),
              _dot(false),
              const SizedBox(width: 10),
              _dot(true),
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
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (state is OnboardingError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              });
            },
            builder: (context, state) {
              return const Text('Skip');
            },
          ),
        ),
      ],
    );
  }

  Container _dot(bool isActive) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: (isActive) ? AppColors.brand : AppColors.brand.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
    );
  }
}
