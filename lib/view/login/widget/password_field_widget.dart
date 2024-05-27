import 'package:chat_app_new/view_model/login_bloc/login_event.dart';
import 'package:chat_app_new/view_model/login_bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../view_model/login_bloc/login_bloc.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: state.isObsecure,
          textCapitalization: TextCapitalization.characters,
          validator: (value) {
            if (value!.isEmpty || value.trim().isEmpty || value.length < 5) {
              return "Invalid Password";
            }
            return null;
          },
          decoration:  InputDecoration(
              labelText: "Password",
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginChangeObsecurePassword());
                  },
                  icon: Icon(state.isObsecure
                      ? Icons.visibility_off
                      : Icons.visibility))),
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginPasswordChanged(value));
          },
        );
      },
    );
  }
}
