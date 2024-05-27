import 'package:chat_app_new/view_model/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late LoginBloc loginBloc;
  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    super.dispose();
    loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        scrolledUnderElevation: 0.0,
      ),
      body: BlocProvider(
        create: (context) => loginBloc,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: context.screenHeight / 7,
              ),
              Card(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const EmailField(),
                        SizedBox(
                          height: context.screenHeight * 0.03,
                        ),
                        const PasswordField(),
                        SizedBox(
                          height: context.screenHeight * 0.02,
                        ),
                        LoginButtonWidget(
                          formkey: _formKey,
                        ),
                        SizedBox(
                          height: context.screenHeight * 0.02,
                        ),
                        const CreateAnAccountWidget()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
