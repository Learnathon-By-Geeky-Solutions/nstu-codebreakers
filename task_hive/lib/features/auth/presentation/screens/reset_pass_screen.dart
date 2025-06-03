import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/di.dart';
import '../../../../core/extensions/app_extension.dart';
import '../cubits/auth/reset_password/reset_pass_cubit.dart';
import '../cubits/validation/otp_validation_cubit.dart';
import '../widgets/otp_field.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/validators/input_field_validation.dart';
import '../cubits/validation/pass_validation_cubit.dart';
import '../widgets/google_sign_in.dart';
import '../widgets/password_field.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key, required this.email});
  final String email;

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final TextEditingController _otpCtrl = TextEditingController();
  final TextEditingController _conPassCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();

  final _passValidationCubit = PasswordValidationCubit();
  final _conPassValidationCubit = PasswordValidationCubit();
  final _otpValidationCubit = OtpValidationCubit();

  final _resetPassCubit = getIt<ResetPasswordCubit>();

  @override
  void dispose() {
    _otpCtrl.dispose();
    _conPassCtrl.dispose();
    _passCtrl.dispose();

    _passValidationCubit.close();
    _conPassValidationCubit.close();
    _otpValidationCubit.close();

    _resetPassCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: _buildBody(context));
  }

  _buildBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Enter valid otp',
              style: textTheme.textxlSemiBold.copyWith(
                color: colorScheme.primary,
              ),
            ),
            SizedBox(height: screenSize.width * .5),
            OtpField(
              screenSize: MediaQuery.sizeOf(context).width,
              hintText: 'Enter otp',
              controller: _otpCtrl,
              otpCubit: _otpValidationCubit,
            ),
            const SizedBox(height: 20),
            PasswordField(
              screenSize: MediaQuery.of(context).size.width,
              hintText: 'Password',
              controller: _passCtrl,
              passCubit: _passValidationCubit,
            ),
            const SizedBox(height: 20),
            PasswordField(
              screenSize: MediaQuery.sizeOf(context).width,
              hintText: 'Confirm Password',
              controller: _conPassCtrl,
              passCubit: _conPassValidationCubit,
            ),
            SizedBox(height: 20),
            _otpSubmitButton(textTheme, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _otpSubmitButton(TextTheme textTheme, ColorScheme colorTheme) {
    return ElevatedButton(
      onPressed: () {
        _validateInput();
      },
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        bloc: _resetPassCubit,
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            showMessage(context, state.success.message, colorTheme.primary);
            context.go(MyRoutes.signInRoute);
          } else if (state is ResetPasswordFailed) {
            showMessage(context, state.failure.message, colorTheme.error);
          }
        },
        builder: (context, state) {
          if (state is ResetPasswordLoading) {
            return const CircularProgressIndicator();
          }
          return Text('Reset Password', style: textTheme.textSmRegular);
        },
      ),
    );
  }

  void _validateInput() {
    final validator = InputFieldValidation();
    String? isOtpValid = validator.otpValidation(_otpCtrl.text.trim());
    String? passValidationStatus = validator.passwordValidation(_passCtrl.text);

    _otpValidationCubit.showError(null);
    _passValidationCubit.showError(null);

    if (isOtpValid != null) {
      _otpValidationCubit.showError(isOtpValid);
    }
    if (passValidationStatus != null) {
      _passValidationCubit.showError(passValidationStatus);
    }
    if (_passCtrl.text != _conPassCtrl.text) {
      _conPassValidationCubit.showError('Passwords must be same');
    }
    if (isOtpValid == null && passValidationStatus == null) {
      _resetPassCubit.resetPassword(
        widget.email,
        _otpCtrl.text.trim(),
        _passCtrl.text.trim(),
      );
    }
  }
}
