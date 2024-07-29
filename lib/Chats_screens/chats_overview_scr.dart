import 'package:flutter/material.dart';
import 'package:helping_hand/LoadingScreen.dart';
import 'package:helping_hand/error.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:provider/provider.dart';

class ChatsOverviewScr extends StatelessWidget {
  const ChatsOverviewScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Messages')),
      ),

      body: FutureBuilder(
          future: FirestoreService().getChats(Provider.of(context).auth.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.hasError) {
              return ErrorMessage(message: snapshot.error.toString());
            } else {
              List<Chat> chats = snapshot.data!;
              return chats.isNotEmpty ? ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return ChatCard(chat: chats[index]);
                },
              ) : const Center(child: Text("No Chats yet!"),);
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
  const ChatCard({required Chat chat,super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => {/*navigate to chat screen*/},
        child: Row(
          children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage("https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
          ),
          Column(
            children: [
              
            ],
          )
        ],)
      )
    );
  }
}