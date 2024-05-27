import 'package:equatable/equatable.dart';

sealed class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EmailChanged extends SignUpEvent {
  final String email;
  EmailChanged(this.email);
}

class PasswordChanged extends SignUpEvent {
  final String password;
  PasswordChanged(this.password);
}

class UserNameChanged extends SignUpEvent {
  final String userName;
  UserNameChanged(this.userName);
}

class PickProfileImage extends SignUpEvent {}

class ChangeObsecurePassword extends SignUpEvent {}

class SignUp extends SignUpEvent {}
