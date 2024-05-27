import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app_new/repository/login_repositoy.dart';
import 'package:chat_app_new/view_model/login_bloc/login_event.dart';
import 'package:chat_app_new/view_model/login_bloc/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../config/network.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository = LoginRepository();
  NetworkManager networkManager = NetworkManager();
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>(_emailChanged);
    on<LoginPasswordChanged>(_passwordChanged);
    on<LoginChangeObsecurePassword>(_toggleObsecure);
    on<LoginIn>(_signin);
  }

  _emailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  _passwordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  _toggleObsecure(LoginChangeObsecurePassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(isObsecure: !state.isObsecure));
  }

  _signin(LoginIn event, Emitter<LoginState> emit) async {
    emit(state.copyWith(logInDataStatus: LogInDataStatus.loading));
    try {
      final isConnected = await networkManager.isConnected();
      if (!isConnected) {
        emit(state.copyWith(
          logInDataStatus: LogInDataStatus.error,
          message: "No Internet Connection",
        ));
        return;
      }
      await loginRepository.loginUser(state.email, state.password);

      emit(state.copyWith(logInDataStatus: LogInDataStatus.success));
    } on SocketException catch (_) {
      emit(state.copyWith(
          logInDataStatus: LogInDataStatus.error,
          message: "No Internet Connection"));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
          logInDataStatus: LogInDataStatus.error,
          message: e.message)); // Passing the Firebase error message
    }
  }
}
