import 'package:chat_app_new/view_model/sign_bloc/sign_up_bloc.dart';
import 'package:chat_app_new/view_model/sign_bloc/sign_up_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpUserNameField extends StatelessWidget {
  const SignUpUserNameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.none,
      validator: (value) {
        if (value!.isEmpty || value.trim().isEmpty) {
          return "Enter a username";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "User Name",
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        context.read<SignUpBloc>().add(UserNameChanged(value));
      },
    );
  }
}
