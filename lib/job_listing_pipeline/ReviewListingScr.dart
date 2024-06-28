import 'package:flutter/material.dart';
import 'package:helping_hand/JobCard.dart';
import 'package:helping_hand/services/models.dart';

part 'review_listing_controller.dart';

class ReviewListingScr extends StatelessWidget {
  final JobPosting jobPosting;
  const ReviewListingScr({required this.jobPosting, super.key});

//submit job listing give jobID
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
                onPressed: () {
                  // send to firestore
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
