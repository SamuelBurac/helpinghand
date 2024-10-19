import 'package:flutter/material.dart';
import 'package:helping_hand/Chats_screens/chat_card.dart';
import 'package:helping_hand/LoadingScreen.dart';
import 'package:helping_hand/error.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:provider/provider.dart';

class ChatsOverviewScr extends StatelessWidget {
  const ChatsOverviewScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Messages')),
      ),
      body: StreamBuilder(
          stream: FirestoreService().getChats(
              Provider.of<UserState>(context, listen: false).user.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.hasError) {
              return ErrorMessage(message: snapshot.error.toString());
            } else {
              List<Chat> chats = snapshot.data!;
              // Sort chats by last message timestamp
              chats.sort((a, b) => b.lastMessageTS.compareTo(a.lastMessageTS));
              return chats.isNotEmpty
                  ? ListView.builder(
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        if (chats[index].chatID != "") {
                          return ChatCard(chat: chats[index]);
                        }
                        return null;
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
