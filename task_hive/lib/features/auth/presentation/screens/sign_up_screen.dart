import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_hive/core/extensions/app_extension.dart';

import '../../../../core/navigation/routes.dart';
import '../../../../core/widgets/custom_input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController conPassCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    conPassCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: _buildBody(colorScheme, textTheme),
    );
  }

  _buildBody(ColorScheme colorScheme, TextTheme textTheme) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: _bodyElements(colorScheme, textTheme),
        ),
      ),
    );
  }

  _bodyElements(ColorScheme colorScheme, TextTheme textTheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        Text(
          'TASK-HIVE',
          style: textTheme.textxlSemiBold.copyWith(color: colorScheme.brand),
        ),
        const SizedBox(height: 10),
        Text(
          'Task Management  App',
          style: textTheme.textBaseMedium.copyWith(
            color: colorScheme.textColor.withOpacity(0.4),
          ),
        ),
        const SizedBox(height: 60),
        Text(
          'Create your account',
          style: textTheme.textSmMedium,
        ),
        const SizedBox(height: 30),
        CustomInputField(
          icon: Icons.person_rounded,
          hintText: 'User Name',
          obscureText: false,
          controller: nameCtrl,
        ),
        const SizedBox(height: 20),
        CustomInputField(
          icon: Icons.email_rounded,
          hintText: 'Email',
          obscureText: false,
          controller: emailCtrl,
        ),
        const SizedBox(height: 20),
        CustomInputField(
          icon: Icons.lock_rounded,
          hintText: 'Password',
          obscureText: true,
          controller: passCtrl,
        ),
        const SizedBox(height: 20),
        CustomInputField(
          icon: Icons.lock_rounded,
          hintText: 'Confirm Password',
          obscureText: true,
          controller: conPassCtrl,
        ),
        const SizedBox(height: 25),
        _signUpButton(textTheme),
        const SizedBox(height: 35),
        Text(
          '- Or Register with -',
          style: textTheme.textSmRegular,
        ),
        const SizedBox(height: 20),
        _googleSignUp(textTheme),
        const SizedBox(height: 20),
        _redirectSignIn(textTheme, colorScheme),
      ],
    );
  }

  Widget _signUpButton(TextTheme textTheme) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        'Register',
        style: textTheme.textSmRegular,
      ),
    );
  }

  Widget _googleSignUp(TextTheme textTheme) {
    return ElevatedButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Image.asset(
              'assets/icons/google.png',
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Sign Up with Google',
            style: textTheme.textSmRegular,
          ),
        ],
      ),
    );
  }

  Widget _redirectSignIn(TextTheme textTheme, ColorScheme colorScheme) {
    return InkWell(
      child: RichText(
        text: TextSpan(
          text: "Already have an account? ",
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: 'Sign in!',
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.brand),
            ),
          ],
        ),
      ),
      onTap: () {
        context.go("/${MyRoutes.signInRoute}");
      },
    );
  }
}
