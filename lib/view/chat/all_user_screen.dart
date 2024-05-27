import 'package:chat_app_new/services/notification_services.dart';
import 'package:chat_app_new/view/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_new/config/helper_function.dart';
import 'package:chat_app_new/view/login/login_screen.dart';
import 'package:chat_app_new/view_model/fetch_user_data/fetch_user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/fetch_user_data/fetch_user_bloc.dart';
import '../../view_model/fetch_user_data/fetch_user_event.dart';

class AllUserScreen extends StatefulWidget {
  const AllUserScreen({super.key});

  @override
  State<AllUserScreen> createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    context.read<FetchUserBloc>().add(FetchUserData());
    notificationServices.requestNotificationPermission();  
    notificationServices.getDeviceToken();
    notificationServices.setUpInteractMessage(context);
    notificationServices.firebaseinit(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                SHelperFunction.nextScreenAndRemovePrevious(
                    const LoginScreen());
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: BlocBuilder<FetchUserBloc, FetchUserState>(
        builder: (context, state) {
          switch (state.fetchUserDataStatus) {
            case FetchUserDataStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case FetchUserDataStatus.error:
              return Center(
                child: Text(state.message),
              );
            case FetchUserDataStatus.success:
              final currentUser = FirebaseAuth.instance.currentUser;
              final otherUsers = state.userModel
                  .where((user) => user.id != currentUser?.uid)
                  .toList();
              return otherUsers.isEmpty
                  ? const Center(
                      child: Text("No User Found!"),
                    )
                  : ListView.builder(
                      itemCount: otherUsers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            SHelperFunction.nextScreen(
                              ChatScreen(
                                userId: otherUsers[index].id!,
                                userName: otherUsers[index].userName!,
                                imageUrl: otherUsers[index].profilePic!,
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            backgroundImage: otherUsers[index]
                                    .profilePic!
                                    .isNotEmpty
                                ? NetworkImage(
                                    otherUsers[index].profilePic!,
                                  )
                                : const NetworkImage(
                                    'https://pics.craiyon.com/2023-07-15/dc2ec5a571974417a5551420a4fb0587.webp'),
                            key: ValueKey(otherUsers[index].id),
                          ),
                          title: Text(otherUsers[index].userName ?? "unkonwn"),
                        );
                      },
                    );
            case FetchUserDataStatus.initial:
            default:
              return const Text("as");
          }
        },
      ),
    );
  }
}
