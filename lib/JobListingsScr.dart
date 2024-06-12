import 'package:flutter/material.dart';
import 'package:helping_hand/LoadingScreen.dart';
import 'package:helping_hand/error.dart';
import 'package:helping_hand/services/models.dart';
import 'JobCard.dart';
import 'services/firestore.dart';

class JobListingsScr extends StatefulWidget {
  const JobListingsScr({
    super.key,
  });

  @override
  State<JobListingsScr> createState() => _JobListingsScrState();
}

class _JobListingsScrState extends State<JobListingsScr> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreService().getJobs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return ErrorMessage(message: snapshot.error.toString());
        } else if (snapshot.hasData) {
          var jobPostings = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: const Center(child: Text("Jobs available")),
              automaticallyImplyLeading: false,
            ),
            body: ListView(
              children:
                  jobPostings.map((job) => JobCard(jobPosting: job)).toList(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _incrementCounter,
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
            ),
          );
        } else {
          return const Text("no jobs found");
        }
      },
    );
  }
}
