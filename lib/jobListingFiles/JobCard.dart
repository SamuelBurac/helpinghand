import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flip_card/flip_card.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:helping_hand/Chats_screens/chat_screen.dart';
import 'package:helping_hand/UserPublicProfileScr.dart';
import 'package:helping_hand/jobListingFiles/JobListingFullScr.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:provider/provider.dart';

class JobCard extends StatelessWidget {
  final JobPosting jobPosting;

  const JobCard({required this.jobPosting, super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 7 / 3.5,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobListingFullScr(
                jobPosting: jobPosting,
              ),
            ),
          );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          flex: 5,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UserPublicProfileScr(
                                              userID: jobPosting.jobPosterID),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 35,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: jobPosting.pfpURL,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              color: Colors.amber,
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(jobPosting.jobPosterName.split(" ")[0],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            height: 1)),
                                    Text(jobPosting.jobPosterName.split(" ")[1],
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            height: 1)),
                                    AnimatedRatingStars(
                                      initialRating: jobPosting.rating,
                                      readOnly: true,
                                      onChanged: (value) {
                                        // is static here
                                      },
                                      emptyColor: Colors.grey.shade900,
                                      customFilledIcon: Icons.star,
                                      customHalfFilledIcon: Icons.star_half,
                                      customEmptyIcon: Icons.star_border,
                                      starSize: 7,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: AutoSizeText(
                          jobPosting.jobTitle,
                          style: const TextStyle(
                            height: 1,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          minFontSize: 15, // the minimum font size you want
                          maxFontSize: 25, // the initial font size
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: FlipCard(
                          fill: Fill.fillBack,
                          direction: FlipDirection.HORIZONTAL,
                          front: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 11, 167, 73),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "\$${jobPosting.jobPay}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const VerticalDivider(
                                      width: 10,
                                    ),
                                    Text(
                                      "${jobPosting.jobDuration}Hrs",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          back: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 11, 167, 73),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                "\$${jobPosting.hourlyRate}/Hr",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 4,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: AutoSizeText(
                                jobPosting.jobLocation,
                                style: const TextStyle(
                                    height: 1, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                minFontSize:
                                    12, // the minimum font size you want
                                maxFontSize: 20, // the initial font size
                              ),
                            ),
                          ],
                        ),
                      ),
                      // put date(s)
                      Flexible(
                        flex: 5,
                        child: jobPosting.oneDay
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    jobPosting.onlyDay!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "From: ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'To: ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        jobPosting.endDate!,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        jobPosting.startDate!,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Table(
                          border: TableBorder.symmetric(
                            inside: BorderSide(
                              color: Colors.blueGrey.shade200,
                              width: 2,
                            ),
                          ),
                          columnWidths: const {
                            0: IntrinsicColumnWidth(), // Adjusts the first column width to fit its content
                            1: FlexColumnWidth(), // Allows the second column to take up the remaining space
                          },
                          children: [
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Text(
                                    "Start",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                  jobPosting.jobStartTime,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Text(
                                  "End",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  jobPosting.jobEndTime,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Details:",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              jobPosting.canPickup
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent.shade700
                                            .withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          "Can Pickup",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          Container(
                            width: 250,
                            height: 50,
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
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      ElevatedButton(
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style!
                            .copyWith(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // adjust the value as needed
                                ),
                              ),
                            ),
                        child: const Text(
                          'Connect',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          DateTime date = DateTime.now();
                          User? interlocutor = await FirestoreService()
                              .getUser(jobPosting.jobPosterID);
                          if (interlocutor == null) {
                            return;
                          }

                          var currId =
                              Provider.of<UserState>(context, listen: false)
                                  .user
                                  .uid;

                          if (currId != jobPosting.jobPosterID) {
                            bool chatExist = await FirestoreService()
                                .checkIfChatExists(
                                    jobPosting.jobPosterID, currId);

                            Chat chat = chatExist
                                ? await FirestoreService()
                                    .getChat(jobPosting.jobPosterID, currId)
                                : Chat(
                                    participants: [
                                        jobPosting.jobPosterID,
                                        currId
                                      ],
                                    createdTS: date,
                                    lastMessageTS: date,
                                    lastMessage: "Send a message");

                            if (!chatExist) {
                              await FirestoreService().addChat(chat);
                            }
                            Navigator.pushNamed(context, "/chatsOverview");

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChatScr(
                                    chat: chat,
                                    interlocutor: interlocutor,
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
