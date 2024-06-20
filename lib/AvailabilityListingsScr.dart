import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:provider/provider.dart';

class AvailabilityListingsScr extends StatelessWidget {
  const AvailabilityListingsScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    selectedBackgroundColors: const [Colors.deepOrangeAccent],
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
                        Navigator.pushNamed(context, "/jobListings");
                      }
                    },
                    isScroll: false,
                  ),
                )
              : const Text("Workers"),
        ),
        automaticallyImplyLeading: false,
      ),
      body: const Text("Availability Listings"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/inputJob");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outlined),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'menu',
          ),
        ],
        onTap: (value) {
          if (value == 1) {
            Navigator.pushNamed(context, "/chatsOverview");
          } else if (value == 2) {
            Navigator.pushNamed(context, "/menu");
          }
        },
      ),
    );
  }
}
