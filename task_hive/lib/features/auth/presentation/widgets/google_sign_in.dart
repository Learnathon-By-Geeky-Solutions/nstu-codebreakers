import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_hive/core/extensions/app_extension.dart';
import '../../../../core/di/di.dart';
import '../../../../core/navigation/routes.dart';
import '../cubits/auth/sign_in/google_sign_in_cubit.dart';

class GoogleSignInSignUpBtn extends StatelessWidget {
  GoogleSignInSignUpBtn({
    super.key,
    required this.textTheme,
    required this.placeholderText,
  });

  final TextTheme textTheme;
  final String placeholderText;
  final _googleSignInCubit = getIt<GoogleSignInCubit>();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _googleSignInCubit.signInWithGoogle();
      },
      child: BlocConsumer<GoogleSignInCubit, GoogleSignInState>(
        bloc: _googleSignInCubit,
        listener: (context, state) {
          if (state is GoogleSignInSuccess) {
            showMessage(
              context,
              state.success.message,
              Theme.of(context).colorScheme.primary,
            );
            context.go(MyRoutes.home);
          } else if (state is GoogleSignInFailed) {
            showMessage(context, state.failure.message, Theme.of(context).colorScheme.error);
          }
        },
        builder: (context, state) {
          if (state is GoogleSignInLoading) {
            return const CircularProgressIndicator();
          }
          return Text(placeholderText);
        },
      ),
    );
  }
}

void showMessage(BuildContext context, String msg, Color color) {
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
