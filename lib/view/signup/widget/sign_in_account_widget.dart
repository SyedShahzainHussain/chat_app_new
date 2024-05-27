import 'package:chat_app_new/config/helper_function.dart';
import 'package:chat_app_new/view/login/login_screen.dart';
import 'package:flutter/material.dart';

class SignInAnAccountWidget extends StatelessWidget {
  const SignInAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        SHelperFunction.nextScreenAndRemovePrevious(const LoginScreen());
      },
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: "Already have an account? ",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer)),
            const TextSpan(text: "Login In"),
          ],
        ),
      ),
    );
  }
}
