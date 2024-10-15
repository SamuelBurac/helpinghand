import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:helping_hand/LoadingScreen.dart';
import 'package:helping_hand/components/PostingFAB.dart';
import 'package:helping_hand/error.dart';
import 'package:helping_hand/components/AdsList.dart';
import 'package:helping_hand/components/NoAds.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:provider/provider.dart';

class AvailabilityListingsScr extends StatefulWidget {
  const AvailabilityListingsScr({super.key});

  @override
  State<AvailabilityListingsScr> createState() =>
      _AvailabilityListingsScrState();
}

class _AvailabilityListingsScrState extends State<AvailabilityListingsScr> {
  late Future<List<dynamic>> _avasFuture;

  @override
  void initState() {
    super.initState();
    _avasFuture = FirestoreService().getAvailabilities();
  }

  Future<void> _refreshAvailabilities() async {
    setState(() {
      _avasFuture = FirestoreService().getAvailabilities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          NoAds(),
        ],
        title: Center(
          child: Provider.of<UserState>(context).user.lookingForWork
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
                        Navigator.popAndPushNamed(context, "/jobListings");
                      }
                    },
                    isScroll: false,
                  ),
                )
              : const Text("Available Employees"),
        ),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        color: Colors.orange,
        onRefresh: _refreshAvailabilities,
        child: FutureBuilder(
            future: _avasFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen();
              } else if (snapshot.hasError) {
                return ErrorMessage(message: snapshot.error.toString());
              } else if (snapshot.hasData) {
                var avaPostings = snapshot.data!;

                return AdsList(
                    items: avaPostings
                        .map((ava) => ListItem(availabilityPosting: ava))
                        .toList());
              } else {
                return const Text("No available people found");
              }
            }),
      ),
      floatingActionButton: Postingfab(),
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
