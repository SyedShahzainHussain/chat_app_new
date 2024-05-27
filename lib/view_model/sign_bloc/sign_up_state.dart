import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

enum SignUpDataStatus { initial, loading, error, success }

class SignUpState extends Equatable {
  final SignUpDataStatus signUpDataStatus;
  final String email;
  final String password;
  final String userName;
  final XFile? image;
  final bool isObsecure;
  final String message;

  const SignUpState({
    this.signUpDataStatus = SignUpDataStatus.initial,
    this.email = '',
    this.password = '',
    this.userName = '',
    this.image,
    this.isObsecure = true,
    this.message = '',
  });

  SignUpState copyWith({
    SignUpDataStatus? signUpDataStatus,
    String? email,
    String? password,
    String? userName,
    XFile? image,
    bool? isObsecure,
    String? message,
  }) {
    return SignUpState(
      email: email ?? this.email,
      image: image ?? this.image,
      isObsecure: isObsecure ?? this.isObsecure,
      signUpDataStatus: signUpDataStatus ?? this.signUpDataStatus,
      password: password ?? this.password,
      userName: userName ?? this.userName,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props =>
      [email, password, image, signUpDataStatus, userName, isObsecure, message];
}
