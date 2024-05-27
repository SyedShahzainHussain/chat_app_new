import './sign_up.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SignUpBloc signUpBloc;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    signUpBloc = SignUpBloc();
  }

  @override
  void dispose() {
    super.dispose();
    signUpBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp"),
        scrolledUnderElevation: 0.0,
      ),
      body: BlocProvider(
        create: (context) => signUpBloc,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: context.screenHeight / 9,
              ),
              const SignUpProfileImage(),
              Card(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        const SignUpUserNameField(),
                        SizedBox(
                          height: context.screenHeight * 0.03,
                        ),
                        const SignUpEmailField(),
                        SizedBox(
                          height: context.screenHeight * 0.03,
                        ),
                        const SignUpPasswordField(),
                        SizedBox(
                          height: context.screenHeight * 0.02,
                        ),
                        SignUpButtonWidget(
                          formkey: _formkey,
                        ),
                        SizedBox(
                          height: context.screenHeight * 0.02,
                        ),
                        const SignInAnAccountWidget()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
