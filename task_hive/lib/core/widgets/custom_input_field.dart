import 'package:flutter/material.dart';
import 'package:task_hive/core/theme/colors.dart';

class CustomInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const CustomInputField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          filled: false,
          prefixIcon: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
              color: AppColors.brand,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
