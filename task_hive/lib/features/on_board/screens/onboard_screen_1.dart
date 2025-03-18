import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_hive/core/extensions/app_extension.dart';
import 'package:task_hive/core/theme/colors.dart';

import '../../../core/navigation/routes.dart';

class OnboardScreen1 extends StatelessWidget {
  const OnboardScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _topElements(context),
            _midElements(textTheme),
            _bottomElements(context),
          ],
        ),
      ),
    );
  }

  Padding _bottomElements(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {
          context.go(MyRoutes.onboard2);
        },
        child: const Text('Next'),
      ),
    );
  }

  SizedBox _midElements(TextTheme textTheme) {
    return SizedBox(
      child: Column(
        children: [
          Image.asset('assets/onboarding/onboard1.png'),
          const SizedBox(height: 20),
          Text(
            'Easy Time Management',
            style: textTheme.textBaseMedium,
          ),
          const SizedBox(height: 20),
          Text(
            'With management based on priority and daily tasks, it will give you convenience in managing and determining the tasks that must be done first ',
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
              _dot(true),
              const SizedBox(width: 10),
              _dot(false),
              const SizedBox(width: 10),
              _dot(false),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            context.go(MyRoutes.signInRoute);
          },
          child: const Text('Skip'),
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
