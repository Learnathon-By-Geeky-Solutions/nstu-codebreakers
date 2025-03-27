import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'input_field_prefix_icon.dart';
import '../cubits/validation/name_validation_cubit.dart';

class NameField extends StatelessWidget {
  const NameField({
    super.key,
    required this.screenSize,
    required this.hintText,
    required this.controller,
    required this.nameCubit,
  });

  final double screenSize;
  final String hintText;
  final TextEditingController controller;
  final NameValidationCubit nameCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NameValidationCubit, String?>(
      bloc: nameCubit,
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
      child: BlocBuilder<NameValidationCubit, String?>(
        bloc: nameCubit,
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
          icon: Icons.person_rounded,
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
