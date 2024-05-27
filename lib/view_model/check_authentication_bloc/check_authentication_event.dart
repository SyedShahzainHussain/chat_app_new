import 'package:equatable/equatable.dart';

sealed class CheckAuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckAuthentication extends CheckAuthenticationEvent {}
