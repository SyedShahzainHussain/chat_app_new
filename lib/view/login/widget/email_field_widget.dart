import 'package:chat_app_new/view/signup/sign_up.dart';
import 'package:chat_app_new/view_model/login_bloc/login_bloc.dart';
import 'package:chat_app_new/view_model/login_bloc/login_event.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: false,
      textCapitalization: TextCapitalization.none,
      validator: (value) {
        if (value!.isEmpty || value.trim().isEmpty) {
          return "Invalid Email";
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
        context.read<LoginBloc>().add(LoginEmailChanged(value));
      },
    );
  }
}
