import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task_hive/features/auth/presentation/cubits/auth/sign_up/sign_up_cubit.dart';

import '../../../../core/di/di.dart';
import '../../../../core/validators/input_field_validation.dart';
import '../cubits/validation/email_validation_cubit.dart';
import '../cubits/validation/name_validation_cubit.dart';
import '../cubits/validation/pass_validation_cubit.dart';
import '../widgets/email_field.dart';
import '../widgets/name_field.dart';
import '../widgets/password_field.dart';
import '../../../../core/extensions/app_extension.dart';
import '../../../../core/navigation/routes.dart';

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

  final _passValidationCubit = PasswordValidationCubit();
  final _conPassValidationCubit = PasswordValidationCubit();
  final _emailValidationCubit = EmailValidationCubit();
  final _nameValidationCubit = NameValidationCubit();

  final _signUpCubit = getIt<SignUpCubit>();

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

    _passValidationCubit.close();
    _nameValidationCubit.close();
    _emailValidationCubit.close();
    _conPassValidationCubit.close();

    _signUpCubit.close();
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
          'Task Management App',
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
        NameField(
          screenSize: MediaQuery.of(context).size.width,
          hintText: 'User Name',
          controller: nameCtrl,
          nameCubit: _nameValidationCubit,
        ),
        const SizedBox(height: 20),
        EmailField(
          screenSize: MediaQuery.of(context).size.width,
          hintText: 'Email',
          controller: emailCtrl,
          emailCubit: _emailValidationCubit,
        ),
        const SizedBox(height: 20),
        PasswordField(
          screenSize: MediaQuery.of(context).size.width,
          hintText: 'Password',
          controller: passCtrl,
          passCubit: _passValidationCubit,
        ),
        const SizedBox(height: 20),
        PasswordField(
          screenSize: MediaQuery.sizeOf(context).width,
          hintText: 'Confirm Password',
          controller: conPassCtrl,
          passCubit: _conPassValidationCubit,
        ),
        const SizedBox(height: 25),
        _signUpButton(textTheme),
        const SizedBox(height: 35),
        Text(
          '- OR -',
          style: textTheme.textSmRegular,
        ),
        const SizedBox(height: 20),
        _googleSignUp(textTheme),
        const SizedBox(height: 20),
        _redirectSignIn(textTheme, colorScheme),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _signUpButton(TextTheme textTheme) {
    return ElevatedButton(
      onPressed: () {
        _validateInput();
      },
      child: BlocConsumer<SignUpCubit, SignUpState>(
        bloc: _signUpCubit,
        listener: (context, state) {
          if (state is SignUpFailed) {
            _showSnackbar(context, state.failure.message, Colors.red);
          } else if (state is SignUpSuccess) {
            _showSnackbar(context, state.success.message, Colors.green);
            context.go('/${MyRoutes.signInRoute}');
          }
        },
        builder: (context, state) {
          if (state is SignUpLoading) {
            return const CircularProgressIndicator();
          }
          return Text(
            'Register',
            style: textTheme.textSmRegular,
          );
        },
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
    bool isEmailValid = validator.emailValidation(emailCtrl.text);
    String? passValidationStatus = validator.passwordValidation(passCtrl.text);
    String? conPassValidionStatus =
        validator.passwordValidation(conPassCtrl.text);
    String? nameValidationStatus = validator.nameValidation(nameCtrl.text);

    _emailValidationCubit.showError(null);
    _passValidationCubit.showError(null);
    _nameValidationCubit.showError(null);

    print('dbg ${(passCtrl.text == conPassCtrl.text)}');
    print('-${passCtrl.text}- -${conPassCtrl.text}-');
    print('dbg vs $conPassValidionStatus');

    if (!isEmailValid) {
      _emailValidationCubit.showError('invalid email');
    }
    if (passValidationStatus != null) {
      _passValidationCubit.showError(passValidationStatus);
    }
    if (conPassValidionStatus != null) {
      print('dbg entered');
      _conPassValidationCubit.showError(conPassValidionStatus);
    }
    if (nameValidationStatus != null) {
      _nameValidationCubit.showError(nameValidationStatus);
    }

    if (passCtrl.text != conPassCtrl.text) {
      print('here dbg');
      _conPassValidationCubit.showError('Passwords must be same');
    }
    if (isEmailValid &&
        passValidationStatus == null &&
        conPassValidionStatus == null &&
        nameValidationStatus == null &&
        passCtrl.text == conPassCtrl.text) {
      print('dbg before calling from screen');
      _signUpCubit.signUp({
        'name': nameCtrl.text,
        'email': emailCtrl.text,
        'password': passCtrl.text,
        'confirmPassword': conPassCtrl.text
      });
    }
  }
}
