import 'package:chat_app_new/view_model/sign_bloc/sign_up_bloc.dart';
import 'package:chat_app_new/view_model/sign_bloc/sign_up_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpEmailField extends StatelessWidget {
  const SignUpEmailField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: false,
      textCapitalization: TextCapitalization.none,
      validator: (value) {
        if (value!.isEmpty || value.trim().isEmpty || !value.contains('@')) {
          return "Enter a valid email";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(),
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        context.read<SignUpBloc>().add(EmailChanged(value));
      },
    );
  }
}
