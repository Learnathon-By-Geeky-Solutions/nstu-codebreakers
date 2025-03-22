import 'package:flutter/material.dart';
import 'package:task_hive/core/extensions/app_extension.dart';
import 'package:task_hive/core/widgets/custom_input_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: _buildBody(textTheme, colorScheme),
    );
  }

  Widget _buildBody(TextTheme textTheme, ColorScheme colorScheme) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: _bodyElemtns(textTheme, colorScheme),
        ),
      ),
    );
  }

  Widget _bodyElemtns(
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
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
          'Login to your account',
          style: textTheme.textSmMedium,
        ),
        const SizedBox(height: 30),
        CustomInputField(
          icon: Icons.email_outlined,
          hintText: 'Email',
          obscureText: false,
          controller: emailCtrl,
        ),
        const SizedBox(height: 20),
        CustomInputField(
          icon: Icons.lock_outline,
          hintText: 'Password',
          obscureText: true,
          controller: passCtrl,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              child: Text(
                "Forgot Password?",
                style: textTheme.textXsRegular.copyWith(
                  color: colorScheme.brand.withOpacity(0.8),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 25),
        _loginButton(textTheme),
        const SizedBox(height: 35),
        Text(
          '- Or log in with -',
          style: textTheme.textSmRegular,
        ),
        const SizedBox(height: 20),
        _googleSignIn(textTheme),
        const SizedBox(height: 20),
        _redirectSignIn(colorScheme),
      ],
    );
  }

  Widget _redirectSignIn(ColorScheme colorScheme) {
    return InkWell(
      child: RichText(
        text: TextSpan(
          text: "Don't have an account? ",
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: 'Sign up!',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: colorScheme.brand),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  Widget _loginButton(TextTheme textTheme) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        'Login',
        style: textTheme.textSmRegular,
      ),
    );
  }

  Widget _googleSignIn(TextTheme textTheme) {
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
            'Sign in with Google',
            style: textTheme.textSmRegular,
          ),
        ],
      ),
    );
  }
}
