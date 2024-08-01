import 'package:flutter/material.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:helping_hand/Chats_screens/chat_screen.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;
  const ChatCard({required this.chat, super.key});

  @override
  Widget build(BuildContext context) {
    User interlocutor = User();
    return Dismissible(
      key: Key(chat.chatID), // Ensure each Dismissible has a unique key
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm"),
              content: const Text("Are you sure you wish to delete this item?"),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("DELETE")),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("CANCEL"),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) => FirestoreService().deleteChat(chat.chatID),
      child: Card(
        child: InkWell(
          onTap: () => {
            if (interlocutor.uid != " " || interlocutor.uid != "")
              {
                if (chat.unreadUID != "" && interlocutor.uid != chat.unreadUID)
                  {
                    FirestoreService().messagesRead(chat.chatID),
                  },
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChatScr(
                        chat: chat,
                        interlocutor: interlocutor,
                      );
                    },
                  ),
                ),
              }
          },
          child: FutureBuilder<User?>(
              future: FirestoreService().getUser(_getInterlocutorUID(
                  chat.participants,
                  Provider.of<UserState>(context, listen: false).user.uid)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading...');
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null) {
                  return const Text('User not found'); // Handle null user
                } else {
                  interlocutor = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: interlocutor.pfpURL,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          color: Colors.amber,
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${interlocutor.firstName} ${interlocutor.lastName}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  chat.lastMessage.length > 40
                                      ? "${chat.lastMessage.substring(0, 40)}..."
                                      : chat.lastMessage,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (chat.unreadUID != "" &&
                            interlocutor.uid != chat.unreadUID)
                          Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            padding: const EdgeInsets.only(
                                left: 7, right: 7, top: 3, bottom: 3),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.redAccent,
                            ),
                            child: const Text(
                              'Unread',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        Column(
                          children: [
                            Text(
                              DateFormat('hh:mm').format(chat.lastMessageTS),
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              DateFormat('MM/dd/yy').format(chat.lastMessageTS),
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}

String _getInterlocutorUID(List<String> participants, String currUID) {
  if (participants.isEmpty || participants.length < 2) {
    throw Exception(
        'Participants list is empty or does not have enough elements');
  }
  if (participants[0] == currUID) {
    return participants[1];
  } else {
    return participants[0];
  }
}
