import 'package:chat_app_new/view_model/sign_bloc/sign_up_event.dart';
import 'package:chat_app_new/view_model/sign_bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view_model/sign_bloc/sign_up_bloc.dart';

class SignUpPasswordField extends StatelessWidget {
  const SignUpPasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: state.isObsecure,
          textCapitalization: TextCapitalization.sentences,
          validator: (value) {
            if (value!.isEmpty || value.trim().isEmpty || value.length < 5) {
              return "Enter a valid password";
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: "Password",
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                  onPressed: () {
                    context.read<SignUpBloc>().add(ChangeObsecurePassword());
                  },
                  icon: Icon(state.isObsecure
                      ? Icons.visibility_off
                      : Icons.visibility))),
          onChanged: (value) {
            context.read<SignUpBloc>().add(PasswordChanged(value));
          },
        );
      },
    );
  }
}
