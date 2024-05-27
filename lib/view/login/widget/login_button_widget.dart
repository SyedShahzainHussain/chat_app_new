import 'package:chat_app_new/view/chat/all_user_screen.dart';
import 'package:chat_app_new/view_model/login_bloc/login_bloc.dart';
import 'package:chat_app_new/view_model/login_bloc/login_event.dart';
import 'package:chat_app_new/view_model/login_bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/flushbar.dart';
import '../../../config/helper_function.dart';

class LoginButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  const LoginButtonWidget({super.key, required this.formkey});

  @override
  Widget build(BuildContext context) {
    void save() {
      final state = BlocProvider.of<LoginBloc>(context);
      final validate = formkey.currentState!.validate();
      if (!validate) return;
      if (validate) {
        FocusScope.of(context).requestFocus(FocusNode());
        state.add(LoginIn());
      }
    }

    return BlocConsumer<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.logInDataStatus != current.logInDataStatus,
      listenWhen: (previous, current) =>
          previous.logInDataStatus != current.logInDataStatus,
      listener: (context, state) {
        if (state.logInDataStatus == LogInDataStatus.success) {
          SHelperFunction.nextScreenAndRemovePrevious(const AllUserScreen());
          FlushBarMessage.showSuccessDialog(context, "User Login!");
        }
        if (state.logInDataStatus == LogInDataStatus.error) {
          FlushBarMessage.showErrorsDialog(context, state.message);
        }
      },
      builder: (context, state) {
        return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom().copyWith(
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primary),
                  foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primaryContainer)),
              onPressed: state.logInDataStatus == LogInDataStatus.loading
                  ? null
                  : () {
                      save();
                    },
              child: state.logInDataStatus == LogInDataStatus.loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text("Login"),
            ));
      },
    );
  }
}
