import 'package:equatable/equatable.dart';

enum LogInDataStatus { initial, loading, error, success }

class LoginState extends Equatable {
  final LogInDataStatus logInDataStatus;
  final String email;
  final String password;
  final bool isObsecure;
  final String message;

  const LoginState({
    this.logInDataStatus = LogInDataStatus.initial,
    this.email = '',
    this.password = '',
    this.isObsecure = true,
    this.message = '',
  });

  LoginState copyWith({
    LogInDataStatus? logInDataStatus,
    String? email,
    String? password,
    bool? isObsecure,
    String? message,
  }) {
    return LoginState(
      email: email ?? this.email,
      isObsecure: isObsecure ?? this.isObsecure,
      logInDataStatus: logInDataStatus ?? this.logInDataStatus,
      password: password ?? this.password,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props =>
      [email, password, logInDataStatus, isObsecure, message];
}
