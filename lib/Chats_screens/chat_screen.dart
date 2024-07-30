import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
part 'chat_screen_controller.dart';

class ChatScr extends StatelessWidget {
  final Chat chat;
  final User interlocutor;
  const ChatScr({required this.interlocutor, required this.chat, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: interlocutor.pfpURL,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          color: Colors.amber,
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text("${interlocutor.firstName} ${interlocutor.lastName}",
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ],
        )),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirestoreService().getMessages(chat.chatID!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('An error occurred'));
                  } else {
                    List<Message> messages = snapshot.data!;
                    return messages.isNotEmpty
                        ? ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              BubbleNormal(
                                text: messages[index].message,
                                isSender: messages[index].senderUID !=
                                    interlocutor.uid,
                                color: Colors.orangeAccent.shade700,
                                tail: true,
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              );
                            },
                          )
                        : const Center(child: Text('No messages yet!'));
                  }
                },
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 65),
              child: const MessageBarBetter(
                hintText: "Hello",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
