import 'package:chat_app_new/services/notification_services.dart';
import 'package:chat_app_new/view/chat/widget/message_bubble.dart';
import 'package:chat_app_new/view/login/login.dart';
import 'package:chat_app_new/view/signup/sign_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String userId;
  final String imageUrl;
  const ChatScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.imageUrl,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  save() async {
    final enteredMessage = _messageController.text;
    if (_messageController.text.isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    _messageController.clear();
    final currentUser = FirebaseAuth.instance.currentUser!;
    final userMessage = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.userId)
        .get();

    final userData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.uid)
        .get();
    await FirebaseFirestore.instance
        .collection('chat')
        .doc(_getChatId())
        .collection('messages')
        .add({
      'text': enteredMessage,
      'senderUid': currentUser.uid,
      'timestamp': Timestamp.now(),
      'username': userData['username'],
      'imageUrl': userData['profilePic'],
    });
    await NotificationServices().sendNotification(
      userMessage['token'],
      userData['username'],
      enteredMessage,
      currentUser.uid,
      userData['profilePic'],
    );
  }

  String _getChatId() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser!.uid.hashCode <= widget.userId.hashCode) {
      return '${currentUser.uid}-${widget.userId}';
    } else {
      return '${widget.userId}-${currentUser.uid}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.userName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('chat')
                      .doc(_getChatId())
                      .collection('messages')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No Messages!"));
                    }
                    final loadedMessages = snapshot.data!.docs;
                    return ListView.builder(
                      padding: const EdgeInsets.only(
                          bottom: 40, left: 13, right: 13),
                      reverse: true,
                      itemBuilder: (context, index) {
                        // ! chat message
                        final chatMessage = loadedMessages[index].data();
                        // ! get next chat if exists
                        final nextChatMessage =
                            index + 1 < loadedMessages.length
                                ? loadedMessages[index + 1].data()
                                : null;
                        // ! get current MessageUser id
                        final currentMessageUserId = chatMessage['senderUid'];
                        // ! get next MessageUser id
                        final nextMessageUserId = nextChatMessage != null
                            ? nextChatMessage['senderUid']
                            : null;
                        // ! now match the id if user same
                        final nextUserIsSame =
                            nextMessageUserId == currentMessageUserId;
                        if (nextUserIsSame) {
                          return MessageBubble.next(
                            message: chatMessage['text'],
                            isMe: currentUser.uid == currentMessageUserId,
                          );
                        } else {
                          return MessageBubble.first(
                            userImage: chatMessage['imageUrl'],
                            message: chatMessage['text'],
                            username: chatMessage['username'],
                            isMe: currentUser.uid == currentMessageUserId,
                          );
                        }
                      },
                      itemCount: loadedMessages.length,
                    );
                  })),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: true,
                    enableSuggestions: true,
                    decoration: const InputDecoration(
                      hintText: "Type your message here...",
                    ),
                  ),
                ),
                IconButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      save();
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
