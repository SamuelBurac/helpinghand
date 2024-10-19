import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:helping_hand/Chats_screens/camera_screen.dart';
import 'package:helping_hand/backend.dart';
import 'package:helping_hand/global_methods.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
part 'chat_screen_controller.dart';

class ChatScr extends StatefulWidget {
  final Chat chat;
  final User interlocutor;

  const ChatScr({required this.interlocutor, required this.chat, super.key});

  @override
  State<ChatScr> createState() => _ChatScrState();
}

class _ChatScrState extends State<ChatScr> {
  final TextEditingController _controller = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            title: InkWell(
          onTap: () {
            navigateToUserPublicProfileScr(
                context,
                widget.interlocutor.uid,
                Provider.of<UserState>(context, listen: false).user.uid);
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.interlocutor.pfpURL,
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
              const SizedBox(width: 10),
              Text(
                  "${widget.interlocutor.firstName} ${widget.interlocutor.lastName}",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold)),
            ],
          ),
        )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirestoreService().getMessages(widget.chat.chatID),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('An error occurred'));
                  } else {
                    List<Message> messages = snapshot.data!;
                    messages.sort(
                        (a, b) => a.timeStampSent.compareTo(b.timeStampSent));
                    _scrollToBottom();
                    return messages.isNotEmpty
                        ? ListView.builder(
                            controller: _scrollController,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              bool addDatechip = false;
                              if (index == 0) {
                                addDatechip = true;
                              } else {
                                if (messages[index].timeStampSent.day !=
                                    messages[index - 1].timeStampSent.day) {
                                  addDatechip = true;
                                }
                              }
                              return Column(
                                children: [
                                  if (addDatechip)
                                    DateChip(
                                      date: messages[index].timeStampSent,
                                      color: Colors.orangeAccent.shade700
                                          .withOpacity(0.5),
                                    ),
                                  if (messages[index].imageUrl != "")
                                    BubbleNormalImage(
                                      id: "${messages[index].senderUID} $index",
                                      image: _image(messages[index].imageUrl),
                                      isSender: messages[index].senderUID !=
                                          widget.interlocutor.uid,
                                      tail: true,
                                    ),
                                  if (messages[index].message != "")
                                    BubbleNormal(
                                      text: messages[index].message,
                                      isSender: messages[index].senderUID !=
                                          widget.interlocutor.uid,
                                      color: Colors.orangeAccent.shade700,
                                      tail: true,
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                ],
                              );
                            },
                          )
                        : const Center(child: Text('No messages yet!'));
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10.0),
              child: MessageBarBetter(
                hintText: "",
                controller: _controller,
                onSend: (String imageURL) async {
                  if (_controller.text.isNotEmpty || imageURL != "") {
                    User currUser = Provider.of<UserState>(context, listen: false)
                                    .user;
                    await FirestoreService().sendMessage(
                        widget.chat.chatID,
                        Message(
                            senderUID:
                                currUser                                    .uid,
                            message: _controller.text,
                            timeStampSent: DateTime.now(),
                            imageUrl: imageURL),
                        widget.interlocutor.uid);

                      sendChatNotification(currUser
                                    .uid, _controller.text, "${currUser.firstName} ${currUser.lastName}", widget.chat.chatID);

                    _controller.clear();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
