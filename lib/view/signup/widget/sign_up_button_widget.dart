import 'package:chat_app_new/config/flushbar.dart';
import 'package:chat_app_new/config/helper_function.dart';
import 'package:chat_app_new/view/chat/all_user_screen.dart';
import 'package:chat_app_new/view/signup/sign_up.dart';
import 'package:chat_app_new/view_model/sign_bloc/sign_up_event.dart';
import 'package:chat_app_new/view_model/sign_bloc/sign_up_state.dart';

class SignUpButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  const SignUpButtonWidget({super.key, required this.formkey});

  @override
  Widget build(BuildContext context) {
    void save() {
      final state = BlocProvider.of<SignUpBloc>(context);
      final validate = formkey.currentState!.validate();
      if (!validate) return;
      if (validate && state.state.image != null) {
        FocusScope.of(context).requestFocus(FocusNode());
        state.add(SignUp());
      }
    }

    return BlocListener<SignUpBloc, SignUpState>(
      listenWhen: (previous, current) =>
          previous.signUpDataStatus != current.signUpDataStatus,
      listener: (context, state) {
        if (state.signUpDataStatus == SignUpDataStatus.success) {
          SHelperFunction.nextScreenAndRemovePrevious(const AllUserScreen());
          FlushBarMessage.showSuccessDialog(context, "User Created!");
        }
        if (state.signUpDataStatus == SignUpDataStatus.error) {
          FlushBarMessage.showErrorsDialog(context, state.message);
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) =>
            previous.signUpDataStatus != current.signUpDataStatus,
        builder: (context, state) {
          return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom().copyWith(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.primary),
                      foregroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.primaryContainer)),
                  onPressed: state.signUpDataStatus == SignUpDataStatus.loading
                      ? null
                      : () {
                          save();
                        },
                  child: state.signUpDataStatus == SignUpDataStatus.loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text("SignUp")));
        },
      ),
    );
  }
}
