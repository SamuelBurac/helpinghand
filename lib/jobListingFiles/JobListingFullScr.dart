import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:helping_hand/UserPublicProfileScr.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:provider/provider.dart';

class JobListingFullScr extends StatelessWidget {
  final JobPosting jobPosting;

  const JobListingFullScr({required this.jobPosting, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserPublicProfileScr(
                      userID: jobPosting.jobPosterID,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: jobPosting.pfpURL,
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
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(jobPosting.jobPosterName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        AnimatedRatingStars(
                          initialRating: jobPosting.rating,
                          readOnly: true,
                          onChanged: (value) {
                            // is static here
                          },
                          customFilledIcon: Icons.star,
                          customHalfFilledIcon: Icons.star_half,
                          customEmptyIcon: Icons.star_border,
                          starSize: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Text(
                  "Position: ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AutoSizeText(
                  jobPosting.jobTitle,
                  style: const TextStyle(
                    height: 1,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  minFontSize: 15, // the minimum font size you want
                  maxFontSize: 20, // the initial font size
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                Text(
                  jobPosting.jobLocation,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Start time: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      jobPosting.jobStartTime,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "End time: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      jobPosting.jobEndTime,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            jobPosting.oneDay
                ? Row(
                    children: [
                      const Text(
                        "Date: ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        jobPosting.onlyDay!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Start Date: ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            jobPosting.startDate!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "End Date: ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            jobPosting.endDate!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    jobPosting.canPickup
                        ? Container(
                            margin: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color:
                                  Colors.greenAccent.shade700.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                "Can Pickup",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                const Divider(),
                Container(
                  width: double.maxFinite,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade300,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      jobPosting.jobDetails,
                      style: const TextStyle(
                        height: 1,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // adjust the value as needed
        ),
        label: const Text(
          'Connect',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          DateTime date = DateTime.now();
          var currId = Provider.of<UserState>(context, listen: false).user.uid;
          if (currId != jobPosting.jobPosterID) {
            bool chatExist = await FirestoreService()
                .checkIfChatExists(jobPosting.jobPosterID, currId);
            if (!chatExist) {
              await FirestoreService().addChat(Chat(
                  participants: [jobPosting.jobPosterID, currId],
                  createdTS: date,
                  lastMessageTS: date,
                  lastMessage: "Send a message"));
            }
          }
        },
      ),
    );
  }
}
