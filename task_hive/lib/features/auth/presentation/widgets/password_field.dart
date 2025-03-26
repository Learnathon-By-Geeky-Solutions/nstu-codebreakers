import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'input_field_prefix_icon.dart';
import '../cubits/validation/pass_validation_cubit.dart';
import '../cubits/validation/text_validation_cubit.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.screenSize,
    required this.hintText,
    required this.controller,
    required this.passCubit,
  });

  final double screenSize;
  final String hintText;
  final TextEditingController controller;
  final PasswordValidationCubit passCubit;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final visibilityCubit = TextVisibilityCubit();

  @override
  void dispose() {
    super.dispose();
    visibilityCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextVisibilityCubit, bool>(
      bloc: visibilityCubit,
      builder: (context, visibility) {
        return Stack(
          children: [
            _inputField(visibility),
            _visibilityIcon(visibility),
          ],
        );
      },
    );
  }

  Positioned _visibilityIcon(bool visibility) {
    return Positioned(
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: IconButton(
          onPressed: () {
            visibilityCubit.changeVisibility();
          },
          icon: (visibility == true)
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      ),
    );
  }

  SizedBox _inputField(bool visibility) {
    return SizedBox(
      width: widget.screenSize,
      child: BlocBuilder<PasswordValidationCubit, String?>(
        bloc: widget.passCubit,
        builder: (context, error) {
          return _textField(visibility, error);
        },
      ),
    );
  }

  TextField _textField(bool visibility, String? error) {
    return TextField(
      controller: widget.controller,
      obscureText: visibility,
      decoration: InputDecoration(
        prefixIcon: const InputFieldPrefixIcon(
          icon: Icons.lock_rounded,
        ),
        error: (error != null)
            ? Text(
                error,
                style: TextStyle(color: Colors.red.shade900),
              )
            : null,
        hintText: widget.hintText,
      ),
    );
  }
}
