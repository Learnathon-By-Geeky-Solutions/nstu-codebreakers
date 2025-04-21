import 'package:flutter/material.dart';
import 'package:task_hive/core/extensions/app_extension.dart';

class GoogleSignInSignUpBtn extends StatelessWidget {
  const GoogleSignInSignUpBtn({
    super.key,
    required this.textTheme,
    required this.onPressed,
    required this.placeholderText,
  });
  final TextTheme textTheme;
  final VoidCallback onPressed;
  final String placeholderText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
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
            placeholderText,
            style: textTheme.textSmRegular,
          ),
        ],
      ),
    );
  }
}
