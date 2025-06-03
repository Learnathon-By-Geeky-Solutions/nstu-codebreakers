import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/validation/otp_validation_cubit.dart';
import 'input_field_prefix_icon.dart';

class OtpField extends StatelessWidget {
  const OtpField({
    super.key,
    required this.screenSize,
    required this.hintText,
    required this.controller,
    required this.otpCubit,
  });

  final double screenSize;
  final String hintText;
  final TextEditingController controller;
  final OtpValidationCubit otpCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpValidationCubit, String?>(
      bloc: otpCubit,
      builder: (context, visibility) {
        return Stack(children: [_inputField()]);
      },
    );
  }

  SizedBox _inputField() {
    return SizedBox(
      width: screenSize,
      child: BlocBuilder<OtpValidationCubit, String?>(
        bloc: otpCubit,
        builder: (context, error) {
          return _textField(error);
        },
      ),
    );
  }

  TextField _textField(String? error) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      decoration: InputDecoration(
        prefixIcon: const InputFieldPrefixIcon(icon: Icons.numbers),
        error: (error != null)
            ? Text(error, style: TextStyle(color: Colors.red.shade900))
            : null,
        hintText: hintText,
      ),
    );
  }
}
