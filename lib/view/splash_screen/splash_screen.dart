import 'dart:async';

import 'package:chat_app_new/config/extension/media_query_extension.dart';
import 'package:chat_app_new/view/chat/all_user_screen.dart';
import 'package:chat_app_new/view/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/image_string.dart';
import 'package:chat_app_new/config/helper_function.dart';
import 'package:chat_app_new/view_model/check_authentication_bloc/check_authentication_state.dart';

import '../../view_model/check_authentication_bloc/check_authentication_bloc.dart';
import '../../view_model/check_authentication_bloc/check_authentication_event.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      context.read<CheckAuthenticationBloc>().add(CheckAuthentication());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckAuthenticationBloc, CheckAuthenticationState>(
      listener: (context, state) {
        if (state.checkAuthenticationStatus ==
            CheckAuthenticationStatus.authorized) {
          SHelperFunction.nextScreenAndRemovePrevious(const AllUserScreen());
        } else if (state.checkAuthenticationStatus ==
            CheckAuthenticationStatus.unauthorized) {
          SHelperFunction.nextScreenAndRemovePrevious(const LoginScreen());
        }
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(SImageString.splashlogo,
                    width: context.screenWidth * 5,
                    height: context.screenHeight / 3),
                Text(
                  "Chat App",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
                SizedBox(height: context.screenHeight / 8),
                const CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          )),
    );
  }
}
