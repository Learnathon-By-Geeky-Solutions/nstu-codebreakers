import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class InputFieldPrefixIcon extends StatelessWidget {
  const InputFieldPrefixIcon({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
