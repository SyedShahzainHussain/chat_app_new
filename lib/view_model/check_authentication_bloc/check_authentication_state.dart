import 'package:equatable/equatable.dart';

enum CheckAuthenticationStatus { initial, authorized, unauthorized }

class CheckAuthenticationState extends Equatable {
  final bool loading;
  final String message;
  final CheckAuthenticationStatus checkAuthenticationStatus;

  const CheckAuthenticationState({
    this.loading = false,
    this.checkAuthenticationStatus = CheckAuthenticationStatus.initial,
    this.message = '',
  });

  CheckAuthenticationState copyWith(
      {bool? loading,
      CheckAuthenticationStatus? checkAuthenticationStatus,
      String? message}) {
    return CheckAuthenticationState(
      loading: loading ?? this.loading,
      checkAuthenticationStatus:
          checkAuthenticationStatus ?? this.checkAuthenticationStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [loading, checkAuthenticationStatus, message];
}
