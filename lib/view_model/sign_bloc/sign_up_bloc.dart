import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app_new/config/image_picker_utils.dart';
import 'package:chat_app_new/repository/sign_repository.dart';
import 'package:chat_app_new/repository/upload_image_repository.dart';
import 'package:chat_app_new/view_model/sign_bloc/sign_up_event.dart';
import 'package:chat_app_new/view_model/sign_bloc/sign_up_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../config/network.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  ImagePickerUtils imagePickerUtils = ImagePickerUtils();
  UploadImagerepository uploadImagerepository = UploadImagerepository();
  SignUpRepository signUpRepository = SignUpRepository();
  NetworkManager networkManager = NetworkManager();
  SignUpBloc() : super(const SignUpState()) {
    on<EmailChanged>(_emailChanged);
    on<PasswordChanged>(_passwordChanged);
    on<UserNameChanged>(_userNameChanged);
    on<PickProfileImage>(_pickProfileImage);
    on<ChangeObsecurePassword>(_toggleObsecure);
    on<SignUp>(_signUp);
  }

  _emailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: event.email));
  }

  _passwordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: event.password));
  }

  _userNameChanged(UserNameChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(userName: event.userName));
  }

  _toggleObsecure(ChangeObsecurePassword event, Emitter<SignUpState> emit) {
    emit(state.copyWith(isObsecure: !state.isObsecure));
  }

  _pickProfileImage(PickProfileImage event, Emitter<SignUpState> emit) async {
    final image = await imagePickerUtils.pickImage();
    emit(state.copyWith(image: image));
  }

  _signUp(SignUp event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(signUpDataStatus: SignUpDataStatus.loading));
    try {
      final isConnected = await networkManager.isConnected();
      if (!isConnected) {
        emit(state.copyWith(
          signUpDataStatus: SignUpDataStatus.error,
          message: "No Internet Connection",
        ));
        return;
      }
      String imageUrl = await uploadImagerepository
          .uploadImageToFirebaseStorage(File(state.image!.path));

      await signUpRepository.signUpUser(
          state.email, state.password, state.userName, imageUrl);
      emit(state.copyWith(signUpDataStatus: SignUpDataStatus.success));
    } on SocketException catch (_) {
      emit(state.copyWith(
          signUpDataStatus: SignUpDataStatus.error,
          message: "No Internet Connection"));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
          signUpDataStatus: SignUpDataStatus.error,
          message: e.message)); // Passing the Firebase error message
    }
  }
}
