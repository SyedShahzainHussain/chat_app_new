import 'package:chat_app_new/view/signup/sign_up.dart';
import 'package:chat_app_new/view_model/check_authentication_bloc/check_authentication_event.dart';
import 'package:chat_app_new/view_model/check_authentication_bloc/check_authentication_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckAuthenticationBloc
    extends Bloc<CheckAuthenticationEvent, CheckAuthenticationState> {
  CheckAuthenticationBloc() : super(const CheckAuthenticationState()) {
    on<CheckAuthentication>(_checkAuthentication);
  }
  _checkAuthentication(
      CheckAuthenticationEvent event, Emitter<CheckAuthenticationState> emit) {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(state.copyWith(
            checkAuthenticationStatus: CheckAuthenticationStatus.authorized,
            message: "User Verified"));
      } else {
        emit(state.copyWith(
            checkAuthenticationStatus: CheckAuthenticationStatus.unauthorized,
            message: "User Not Verified"));
      }
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }
}
