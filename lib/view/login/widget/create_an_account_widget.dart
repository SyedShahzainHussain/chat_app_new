import 'package:chat_app_new/config/helper_function.dart';
import 'package:chat_app_new/view/signup/signup_screen.dart';
import 'package:flutter/material.dart';

class CreateAnAccountWidget extends StatelessWidget {
  const CreateAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        SHelperFunction.nextScreenAndRemovePrevious(const SignUpScreen());
      },
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: "Don't have an account? ",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer)),
            const TextSpan(text: "Sign Up"),
          ],
        ),
      ),
    );
  }
}
