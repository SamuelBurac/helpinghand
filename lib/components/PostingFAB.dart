import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/components/ListingPremiumPrompt.dart';
import 'package:provider/provider.dart';

class Postingfab extends StatelessWidget {
  const Postingfab({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
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
            onTap: () async {
              if (Provider.of<UserState>(context, listen: false)
                      .user
                      .isPremium ||
                  Provider.of<UserState>(context, listen: false)
                          .user
                          .numPostsLeft >
                      0) {
                Navigator.pushNamed(context, "/inputAvailability");
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ListingPremiumPrompt(nextRoute: "/inputAvailability"),
                  ),
                );
              }
            },
          ),
        // Case 2: User is looking for workers but not work
        if (Provider.of<UserState>(context).user.lookingForWorkers)
          SpeedDialChild(
            child: const Icon(Icons.add),
            backgroundColor: Colors.orange,
            label: 'Add Job',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () async {
              if (Provider.of<UserState>(context, listen: false)
                      .user
                      .isPremium ||
                  Provider.of<UserState>(context, listen: false)
                          .user
                          .numPostsLeft >
                      0) {
                if (Provider.of<UserState>(context, listen: false)
                        .user
                        .numPostsLeft >
                    0) {
                  await FirestoreService().updateUser(
                      Provider.of<UserState>(context, listen: false).user);
                }
                Navigator.pushNamed(context, "/inputJob");
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ListingPremiumPrompt(nextRoute: "/inputJob"),
                  ),
                );
              }
            },
          ),
      ],
    );
  }
}
