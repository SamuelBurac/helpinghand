import 'package:flutter/material.dart';
import 'package:helping_hand/LoadingScreen.dart';
import 'package:helping_hand/error.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

part 'chats_overview_controller.dart';

class ChatsOverviewScr extends StatelessWidget {
  const ChatsOverviewScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Messages')),
      ),
      body: FutureBuilder(
          future: FirestoreService().getChats(
              Provider.of<UserState>(context, listen: false).user.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.hasError) {
              return ErrorMessage(message: snapshot.error.toString());
            } else {
              List<Chat> chats = snapshot.data!;
              return chats.isNotEmpty
                  ? ListView.builder(
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        return ChatCard(chat: chats[index]);
                      })
                  : const Center(
                      child: Text("No Chats yet!"),
                    );
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor:
            Colors.orange, // Set the color for selected item (icon + text)
        unselectedItemColor: const Color.fromARGB(149, 255, 172,
            64), // Set the color for unselected items (icon + text)
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.work_outlined,
            ),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            label: 'Menu',
          ),
        ],
        onTap: (value) {
          if (value == 0) {
            Navigator.popAndPushNamed(context, "/");
          } else if (value == 2) {
            Navigator.popAndPushNamed(context, "/menu");
          }
        },
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  final Chat chat;
  const ChatCard({required this.chat, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => {/*navigate to chat screen*/},
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
                User user = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: user.pfpURL != ""
                            ? NetworkImage(user.pfpURL)
                            : const AssetImage("assets/emptyProfilePic.png")
                                as ImageProvider<Object>,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${user.firstName} ${user.lastName}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                chat.lastMessage,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
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
    );
  }
}
