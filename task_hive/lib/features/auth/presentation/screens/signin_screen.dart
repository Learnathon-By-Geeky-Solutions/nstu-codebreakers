import 'package:flutter/material.dart';
import 'package:task_hive/core/extensions/app_extension.dart';
import 'package:task_hive/features/auth/presentation/widgets/custom_input_field.dart';

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
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Text(
                  'TASK-HIVE',
                  style: textTheme.textxlSemiBold.copyWith(color: scheme.brand),
                ),
                SizedBox(height: 10),
                Text(
                  'Management  App',
                  style: textTheme.textBaseMedium,
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
                          color: scheme.brand.withOpacity(0.8),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Sign In',
                    // style: textTheme.text2xlMedium.copyWith(
                    //   color: scheme.textColor,
                    // ),
                  ),
                ),
                const SizedBox(height: 35),
                Text(
                  '- Or log in with -',
                  style: textTheme.textSmRegular,
                ),
                const SizedBox(height: 20),
                InkWell(
                  child: Image.asset(
                    'assets/icons/google.png',
                    width: 20,
                    height: 20,
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                InkWell(
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
                              ?.copyWith(color: scheme.brand),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
