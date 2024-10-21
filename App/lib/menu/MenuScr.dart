import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:helping_hand/LoadingScreen.dart';
import 'package:helping_hand/error.dart';
import 'package:helping_hand/menu/AvailabilityListingCard.dart';
import 'package:helping_hand/menu/JobListingCard.dart';
import 'package:helping_hand/menu/SettingsPage.dart';
import 'package:helping_hand/services/NotificationsProvider.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/auth.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:provider/provider.dart';

part 'MenuController.dart';

class MenuScr extends StatelessWidget {
  const MenuScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: Provider.of<UserState>(context).user.pfpURL,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${Provider.of<UserState>(context).user.firstName} ${Provider.of<UserState>(context).user.lastName}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        AnimatedRatingStars(
                          initialRating:
                              Provider.of<UserState>(context).user.rating,
                          readOnly: true,
                          onChanged: (value) {
                            // is static here
                          },
                          emptyColor: Colors.grey,
                          customFilledIcon: Icons.star,
                          customHalfFilledIcon: Icons.star_half,
                          customEmptyIcon: Icons.star_border,
                          starSize: 21,
                        ),
                      ],
                    ),
                  ),
                  if (!Provider.of<UserState>(context).user.isPremium) ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.purple.shade900,
                      elevation: 8,
                      shadowColor: Colors.amberAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side:
                            BorderSide(color: Colors.amber.shade600, width: 2),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implement premium purchase logic
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star,
                            color: Colors.purple.shade900, size: 23),
                        SizedBox(width: 12),
                        Text(
                          "Buy Premium",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style!
                        .copyWith(
                          backgroundColor:  WidgetStateProperty.all<Color>(Colors.blueGrey),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // adjust the value as needed
                            ),
                          ),
                        ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const SettingsPage();
                      }));
                    },
                    label: const Text("Settings"),
                    icon: const Icon(Icons.settings)),
                ElevatedButton.icon(
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style!
                        .copyWith(
                          backgroundColor: WidgetStateProperty.all<Color>(Colors.red.shade600),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // adjust the value as needed
                            ),
                          ),
                        ),
                    onPressed: () async {
                      await Provider.of<NotificationPreferences>(context, listen: false)
                          .messagingService.removeToken();
                      FirebaseAuth.instance.signOut();
                      Navigator.popAndPushNamed(context, "/startup");
                    },
                    label: const Text("Log Out"),
                    icon: const Icon(Icons.logout)),
              ],
            ),
          ),
          Flexible(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ChangeNotifierProvider(
                create: (context) => PostingsState(context),
                child: Consumer<PostingsState>(
                  builder: (context, state, child) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(35, 238, 238, 238),
                        border: Border.all(
                          color: Colors.grey,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (Provider.of<PostingsState>(context,
                                    listen: false)
                                .giveOptions)
                              Theme(
                                data: ThemeData(
                                  buttonTheme: const ButtonThemeData(),
                                ),
                                child: FlutterToggleTab(
                                  width: 70, // width in percent
                                  borderRadius: 10,
                                  height: 30,
                                  selectedIndex: Provider.of<PostingsState>(
                                          context,
                                          listen: false)
                                      .selectedLabelIndex,
                                  selectedBackgroundColors: [
                                    Colors.orange.shade600
                                  ],
                                  unSelectedBackgroundColors: [
                                    Colors.orangeAccent.shade100
                                  ],
                                  selectedTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                  unSelectedTextStyle: const TextStyle(
                                      color: Color.fromARGB(202, 69, 90, 100),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                  labels: const ["Jobs", "Availabilities"],
                                  selectedLabelIndex: (index) {
                                    if (index == 1) {
                                      Provider.of<PostingsState>(context,
                                              listen: false)
                                          .showJobListings = false;
                                      Provider.of<PostingsState>(context,
                                              listen: false)
                                          .selectedLabelIndex = 1;
                                    } else {
                                      Provider.of<PostingsState>(context,
                                              listen: false)
                                          .showJobListings = true;
                                      Provider.of<PostingsState>(context,
                                              listen: false)
                                          .selectedLabelIndex = 0;
                                    }
                                  },
                                  isScroll: false,
                                ),
                              )
                            else if (Provider.of<PostingsState>(context,
                                    listen: false)
                                .showJobListings)
                              Text(
                                "Job Postings",
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              )
                            else
                              Text(
                                "Availability Postings",
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            const Divider(),
                            Expanded(
                              child: Provider.of<PostingsState>(context,
                                          listen: false)
                                      .showJobListings
                                  ? StreamBuilder(
                                      stream: FirestoreService()
                                          .streamJobs(AuthService().user!.uid),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const LoadingScreen();
                                        } else if (snapshot.hasError) {
                                          return ErrorMessage(
                                              message:
                                                  snapshot.error.toString());
                                        } else if (snapshot.hasData) {
                                          var jobPostings = snapshot.data!;

                                          return ListView(
                                            children: jobPostings
                                                .map((job) => JobListingCard(
                                                    jobPosting: job))
                                                .toList(),
                                          );
                                        } else {
                                          return const Text("no jobs found");
                                        }
                                      })
                                  : StreamBuilder(
                                      stream: FirestoreService()
                                          .streamAvailabilitiesFiltered(
                                              AuthService().user!.uid),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const LoadingScreen();
                                        } else if (snapshot.hasError) {
                                          return ErrorMessage(
                                              message:
                                                  snapshot.error.toString());
                                        } else if (snapshot.hasData) {
                                          var avaPostings = snapshot.data!;

                                          return ListView(
                                            children: avaPostings
                                                .map((ava) =>
                                                    AvailabilityListingCard(
                                                        availabilityPosting:
                                                            ava))
                                                .toList(),
                                          );
                                        } else {
                                          return const Text("no jobs found");
                                        }
                                      }),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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
          } else if (value == 1) {
            Navigator.popAndPushNamed(context, "/chatsOverview");
          }
        },
      ),
    );
  }
}
