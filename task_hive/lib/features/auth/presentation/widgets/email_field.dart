import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'input_field_prefix_icon.dart';
import '../cubits/validation/email_validation_cubit.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.screenSize,
    required this.hintText,
    required this.controller,
    required this.emailCubit,
  });

  final double screenSize;
  final String hintText;
  final TextEditingController controller;
  final EmailValidationCubit emailCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailValidationCubit, String?>(
      bloc: emailCubit,
      builder: (context, visibility) {
        return Stack(
          children: [
            _inputField(),
          ],
        );
      },
    );
  }

  SizedBox _inputField() {
    return SizedBox(
      width: screenSize,
      child: BlocBuilder<EmailValidationCubit, String?>(
        bloc: emailCubit,
        builder: (context, error) {
          return _textField(error);
        },
      ),
    );
  }

  TextField _textField(String? error) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: const InputFieldPrefixIcon(
          icon: Icons.email_rounded,
        ),
        error: (error != null)
            ? Text(
                error,
                style: TextStyle(color: Colors.red.shade900),
              )
            : null,
        hintText: hintText,
      ),
    );
  }
}
