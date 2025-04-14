import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_hive/core/extensions/app_extension.dart';
import 'package:task_hive/core/navigation/router_config.dart';
import 'package:task_hive/core/navigation/routes.dart';
import 'package:task_hive/features/auth/presentation/cubits/auth/forget_password/forget_pass_cubit.dart';
import 'package:task_hive/features/auth/presentation/cubits/validation/email_validation_cubit.dart';
import 'package:task_hive/features/auth/presentation/widgets/email_field.dart';

import '../../../../core/di/di.dart';
import '../../../../core/validators/input_field_validation.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailCtrl = TextEditingController();
  final _emailCubit = EmailValidationCubit();

  final _forgetPassCubit = getIt<ForgetPasswordCubit>();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _forgetPassCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter email',
                style: textTheme.textBaseMedium.copyWith(
                  color: colorScheme.tertiary,
                ),
              ),
              const SizedBox(height: 20),
              EmailField(
                screenSize: MediaQuery.sizeOf(context).width,
                hintText: 'email',
                controller: _emailCtrl,
                emailCubit: _emailCubit,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _validateInput();
                },
                child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                  bloc: _forgetPassCubit,
                  listener: (context, state) {
                    if (state is ForgetPasswordFailed) {
                      _showSnackbar(
                        context,
                        state.failure.message,
                        colorScheme.error,
                      );
                    } else if (state is ForgetPasswordSuccess) {
                      context.go(MyRoutes.signInRoute);
                    }
                  },
                  builder: (context, state) {
                    if (state is ForgetPasswordLoading) {
                      return const CircularProgressIndicator();
                    }
                    return const Text('submit');
                  },
                ),
              ),
            ],
          ),
        ),
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
    _emailCubit.showError(null);

    if (!isEmailValid) {
      _emailCubit.showError('invalid email');
    }

    if (isEmailValid) {
      _forgetPassCubit.forgetPassword(_emailCtrl.text);
    }
  }
}
