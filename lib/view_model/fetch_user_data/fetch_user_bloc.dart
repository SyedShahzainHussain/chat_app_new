import 'package:chat_app_new/view/signup/sign_up.dart';
import 'package:chat_app_new/view_model/fetch_user_data/fetch_user_event.dart';
import 'package:chat_app_new/view_model/fetch_user_data/fetch_user_state.dart';

import '../../repository/get_user_repository.dart';

class FetchUserBloc extends Bloc<FetchUserEvent, FetchUserState> {
  GetUserRepository getUserRepository = GetUserRepository();
  FetchUserBloc() : super(const FetchUserState()) {
    on<FetchUserData>(_fetchUserData);
  }

  _fetchUserData(FetchUserData event, Emitter<FetchUserState> emit) async {
    emit(state.copyWith(fetchUserDataStatus: FetchUserDataStatus.loading));
    try {
      final user = await getUserRepository.getUserData();

      if (user.isEmpty) {
        emit(state.copyWith(
          fetchUserDataStatus: FetchUserDataStatus.success,
          userModel: [],
        ));
      } else {
        emit(state.copyWith(
          fetchUserDataStatus: FetchUserDataStatus.success,
          userModel: user,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        fetchUserDataStatus: FetchUserDataStatus.error,
        userModel: [],
        message: e.toString(),
      ));
    }
  }
}
