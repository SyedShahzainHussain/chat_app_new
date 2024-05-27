import 'dart:io';

import 'package:chat_app_new/view_model/sign_bloc/sign_up_bloc.dart';
import 'package:chat_app_new/view_model/sign_bloc/sign_up_event.dart';
import 'package:chat_app_new/view_model/sign_bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpProfileImage extends StatelessWidget {
  const SignUpProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              backgroundImage: state.image == null
                  ? null
                  : FileImage(File(state.image!.path)),
            ),
            TextButton(
                onPressed: () {
                  context.read<SignUpBloc>().add(PickProfileImage());
                },
                child: const Text("Add Image"))
          ],
        );
      },
    );
  }
}
