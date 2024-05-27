import 'package:equatable/equatable.dart';

sealed class FetchUserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUserData extends FetchUserEvent {}
