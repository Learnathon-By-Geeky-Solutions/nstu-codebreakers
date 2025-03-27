import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_hive/core/theme/colors.dart';
import 'package:task_hive/features/auth/presentation/cubits/auth/sign_in/sign_in_cubit.dart';

import '../../../../core/di/di.dart';
import '../../../../core/extensions/app_extension.dart';
import '../../../../core/validators/input_field_validation.dart';
import '../cubits/validation/email_validation_cubit.dart';
import '../cubits/validation/pass_validation_cubit.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../../../../core/navigation/routes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  final _passValidationCubit = PasswordValidationCubit();
  final _emailValidationCubit = EmailValidationCubit();

  final _signInCubit = getIt<SignInCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();

    _emailValidationCubit.close();
    _passValidationCubit.close();
    _signInCubit.close();

    super.dispose();
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
          child: _bodyElements(textTheme, colorScheme),
        ),
      ),
    );
  }

  Widget _bodyElements(
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
        EmailField(
          screenSize: MediaQuery.sizeOf(context).width,
          hintText: 'Email',
          controller: _emailCtrl,
          emailCubit: _emailValidationCubit,
        ),
        const SizedBox(height: 20),
        PasswordField(
          screenSize: MediaQuery.sizeOf(context).width,
          hintText: 'Password',
          controller: _passCtrl,
          passCubit: _passValidationCubit,
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
          '- OR -',
          style: textTheme.textSmRegular,
        ),
        const SizedBox(height: 20),
        _googleSignIn(textTheme),
        const SizedBox(height: 20),
        _redirectSignUp(colorScheme),
      ],
    );
  }

  Widget _redirectSignUp(ColorScheme colorScheme) {
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
      onTap: () {
        context.go("/${MyRoutes.signUpRoute}");
      },
    );
  }

  Widget _loginButton(TextTheme textTheme) {
    return ElevatedButton(
      onPressed: () {
        _validateInput();
      },
      child: BlocConsumer<SignInCubit, SignInState>(
        bloc: _signInCubit,
        listener: (context, state) {
          if (state is SignInSuccess) {
            context.go(MyRoutes.profile);
          } else if (state is SignInFailed) {
            _showSnackbar(context, state.failure.message, AppColors.alert);
          }
        },
        builder: (context, state) {
          if (state is SignInLoading) {
            return const CircularProgressIndicator();
          }
          return Text(
            'Login',
            style: textTheme.textSmRegular,
          );
        },
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

  void _showSnackbar(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          msg,
          style: Theme.of(context).textTheme.textSmRegular,
        ),
      ),
    );
  }

  void _validateInput() {
    final validator = InputFieldValidation();
    bool isEmailValid = validator.emailValidation(_emailCtrl.text);
    String? passValidationStatus = validator.passwordValidation(_passCtrl.text);

    _emailValidationCubit.showError(null);
    _passValidationCubit.showError(null);

    if (!isEmailValid) {
      _emailValidationCubit.showError('invalid email');
    }
    if (passValidationStatus != null) {
      _passValidationCubit.showError(passValidationStatus);
    }

    if (isEmailValid && passValidationStatus == null) {
      _signInCubit.signIn({
        'email': _emailCtrl.text,
        'password': _passCtrl.text,
      });
    }
  }
}
