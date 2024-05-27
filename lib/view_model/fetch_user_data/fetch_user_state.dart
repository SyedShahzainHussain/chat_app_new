import 'package:chat_app_new/model/user_model.dart';
import 'package:equatable/equatable.dart';

enum FetchUserDataStatus { initial, loading, success, error }

class FetchUserState extends Equatable {
  final FetchUserDataStatus fetchUserDataStatus;
  final List<UserModel> userModel;
  final String message;

  const FetchUserState({
    this.fetchUserDataStatus = FetchUserDataStatus.initial,
    this.message = '',
    this.userModel = const [],
  });
  FetchUserState copyWith(
      {FetchUserDataStatus? fetchUserDataStatus,
      List<UserModel>? userModel,
      String? message}) {
    return FetchUserState(
      fetchUserDataStatus: fetchUserDataStatus ?? this.fetchUserDataStatus,
      message: message ?? this.message,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object?> get props => [message, fetchUserDataStatus, userModel];
}
