import 'package:flutter/material.dart';
import 'package:helping_hand/LoadingScreen.dart';
import 'package:helping_hand/error.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:provider/provider.dart';
import 'JobCard.dart';
import 'services/firestore.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class JobListingsScr extends StatefulWidget {
  const JobListingsScr({
    super.key,
  });

  @override
  State<JobListingsScr> createState() => _JobListingsScrState();
}

class _JobListingsScrState extends State<JobListingsScr> {
  int _tabSelectedIndexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Provider.of<UserState>(context).user.lookingForWorkers
              ? FlutterToggleTab(
                  width: 90,
                  borderRadius: 15,
                  selectedIndex: _tabSelectedIndexSelected,
                  selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  unSelectedTextStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  labels: const ["Jobs", "Availabile Workers"],
                  selectedLabelIndex: (index) {
                    setState(() {
                      _tabSelectedIndexSelected = index;
                    });
                    Navigator.pushNamed(context, "/availabilityListings");
                  },
                )
              : const Text("Jobs"),
        ),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
          future: FirestoreService().getJobs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.hasError) {
              return ErrorMessage(message: snapshot.error.toString());
            } else if (snapshot.hasData) {
              var jobPostings = snapshot.data!;

              return ListView(
                children:
                    jobPostings.map((job) => JobCard(jobPosting: job)).toList(),
              );
            } else {
              return const Text("no jobs found");
            }
          }),
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
          if (value == 0) {
            Navigator.pushNamed(context, "/jobListings");
          } else if (value == 1) {
            Navigator.pushNamed(context, "/chatsOverview");
          } else if (value == 2) {
            Navigator.pushNamed(context, "/menu");
          }
        },
      ),
    );
  }
}
