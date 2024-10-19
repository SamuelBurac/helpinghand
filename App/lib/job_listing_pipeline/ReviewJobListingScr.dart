import 'package:flutter/material.dart';
import 'package:helping_hand/jobListingFiles/JobCard.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:provider/provider.dart';


class ReviewListingScr extends StatelessWidget {
  final JobPosting jobPosting;
  const ReviewListingScr({required this.jobPosting, super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text("Review Job Listing")),
      ),
      body: Column(
        children: [
          JobCard(jobPosting: jobPosting),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Go back"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirestoreService().addJob(jobPosting);
                  Provider.of<UserState>(context, listen: false)
                      .decrementPostsLeft();
                  await FirestoreService().updateUser(
                      Provider.of<UserState>(context, listen: false).user);
                  Navigator.popAndPushNamed(context, "/");
                },
                child: const Text("Submit Job Listing"),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}
