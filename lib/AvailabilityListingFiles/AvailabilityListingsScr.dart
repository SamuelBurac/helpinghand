import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:helping_hand/AvailabilityListingFiles/AvailabilityCard.dart';
import 'package:helping_hand/LoadingScreen.dart';
import 'package:helping_hand/error.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:provider/provider.dart';

class AvailabilityListingsScr extends StatelessWidget {
  const AvailabilityListingsScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Provider.of<UserState>(context).user.lookingForWorkers
              ? Theme(
                  data: ThemeData(
                    buttonTheme: const ButtonThemeData(),
                  ),
                  child: FlutterToggleTab(
                    width: 70, // width in percent
                    borderRadius: 20,
                    height: 40,
                    selectedIndex: 1,
                    selectedBackgroundColors: [Colors.orange.shade600],
                    unSelectedBackgroundColors: [Colors.orangeAccent.shade100],
                    selectedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                    unSelectedTextStyle: const TextStyle(
                        color: Color.fromARGB(202, 69, 90, 100),
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                    labels: const ["Jobs", "Workers"],
                    selectedLabelIndex: (index) {
                      if (index == 0) {
                        Navigator.popAndPushNamed(
                            context, "/jobListings");
                      }
                    },
                    isScroll: false,
                  ),
                )
              : const Text("Jobs"),
        ),
        automaticallyImplyLeading: false,
      ),
      body:  FutureBuilder(
          future: FirestoreService().getAvailabilities(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.hasError) {
              return ErrorMessage(message: snapshot.error.toString());
            } else if (snapshot.hasData) {
              var avaPostings = snapshot.data!;

              return ListView(
                children:
                    avaPostings.map((ava) => AvailabilityCard(availabilityPosting: ava)).toList(),
              );
            } else {
              return const Text("no jobs found");
            }
          }),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.orange,
        children: [
          // Case 1: User is looking for work but not workers
          if (Provider.of<UserState>(context).user.lookingForWork)
            SpeedDialChild(
              child: const Icon(Icons.calendar_month),
              backgroundColor: Colors.orange,
              label: 'Add Availability',
              labelStyle: const TextStyle(fontSize: 18.0),
              onTap: () {
                Navigator.pushNamed(context, "/inputAvailability");
              },
            ),
          // Case 2: User is looking for workers but not work
          if (Provider.of<UserState>(context).user.lookingForWorkers)
            SpeedDialChild(
              child: const Icon(Icons.add),
              backgroundColor: Colors.orange,
              label: 'Add Job',
              labelStyle: const TextStyle(fontSize: 18.0),
              onTap: () {
                Navigator.pushNamed(context, "/inputJob");
              },
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          if (value == 1) {
            Navigator.popAndPushNamed(context, "/chatsOverview");
          } else if (value == 2) {
            Navigator.popAndPushNamed(context, "/menu");
          }
        },
      ),
    );
  }
}
