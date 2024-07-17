import 'package:flutter/material.dart';
import 'package:helping_hand/AvailabilityListingFiles/AvailabilityCard.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';

class ReviewPersonListingScr extends StatelessWidget {
  final AvailabilityPosting avaPosting;
  const ReviewPersonListingScr({required this.avaPosting, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text("Review Availability")),
      ),
      body: Column(
        children: [
          AvailabilityCard(availabilityPosting: avaPosting),
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
                  await FirestoreService().addAvailability(avaPosting);
                  Navigator.popAndPushNamed(context, "/");
                },
                child: const Text("Submit Availability"),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}