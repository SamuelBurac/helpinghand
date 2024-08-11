import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:helping_hand/AvailabilityListingFiles/AvailabilityListingFScr.dart';
import 'package:helping_hand/Chats_screens/chat_screen.dart';
import 'package:helping_hand/global_methods.dart';
import 'package:helping_hand/public_profile/UserPublicProfileScr.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AvailabilityCard extends StatelessWidget {
  final AvailabilityPosting availabilityPosting;

  const AvailabilityCard({required this.availabilityPosting, super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 7 / 3.5,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AvailabilityListingFScr(
                avaPosting: availabilityPosting,
              ),
            ),
          );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: double.infinity,
                maxHeight: double.infinity,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Flexible(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            navigateToUserPublicProfileScr(
                                context,
                                availabilityPosting.posterID,
                                Provider.of<UserState>(context, listen: false)
                                    .user
                                    .uid);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: availabilityPosting.pfpURL,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(availabilityPosting.jobPosterName,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      height: 1)),
                              AnimatedRatingStars(
                                initialRating: availabilityPosting.rating,
                                readOnly: true,
                                onChanged: (value) {
                                  // is static here
                                },
                                emptyColor: Colors.grey.shade900,
                                customFilledIcon: Icons.star,
                                customHalfFilledIcon: Icons.star_half,
                                customEmptyIcon: Icons.star_border,
                                starSize: 13,
                              )
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                ),
                                AutoSizeText(
                                  availabilityPosting.generalLocation,
                                  style: const TextStyle(
                                      height: 1, fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  minFontSize:
                                      15, // the minimum font size you want
                                  maxFontSize: 25, // the initial font size
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 5,
                    child: availabilityPosting.rangeOfDates
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Available from: ",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 2.5, right: 2.5),
                                decoration: BoxDecoration(
                                  color: Colors.amber.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 2.0,
                                      left: 2.0,
                                      right: 6.0),
                                  child: Text(
                                    " ${availabilityPosting.startDate!} ${getDayName(availabilityPosting.startDate!)}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                " - ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 2.5, right: 2.5),
                                decoration: BoxDecoration(
                                  color: Colors.amber.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 2.0,
                                      left: 2.0,
                                      right: 6.0),
                                  child: Text(
                                    " ${availabilityPosting.endDate!} ${getDayName(availabilityPosting.endDate!)}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Available on: ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  availabilityPosting.needsPickup
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                              top: 5,
                                              left: 2,
                                              right: 5,
                                              bottom: 2),
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .deepOrangeAccent.shade700
                                                .withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: Text(
                                              "Needs pickup",
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: availabilityPosting
                                        .availabilityDates!
                                        .take(3)
                                        .map((date) => Container(
                                              margin: const EdgeInsets.only(
                                                  left: 2.5,
                                                  right: 2.5,
                                                  bottom: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.amber
                                                    .withOpacity(0.6),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2.0,
                                                    bottom: 2.0,
                                                    left: 2.0,
                                                    right: 6.0),
                                                child: Text(
                                                  " $date ${getDayName(date)}",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                  if (availabilityPosting
                                          .availabilityDates!.length >
                                      3)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: availabilityPosting
                                          .availabilityDates!
                                          .skip(3)
                                          .map((date) => Container(
                                                margin: const EdgeInsets.only(
                                                    left: 2.5,
                                                    right: 2.5,
                                                    bottom: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.amber
                                                      .withOpacity(0.6),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0,
                                                          bottom: 2.0,
                                                          left: 2.0,
                                                          right: 6.0),
                                                  child: Text(
                                                    " $date ${getDayName(date)}",
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                ],
                              ),
                            ],
                          ),
                  ),
                  Flexible(
                    flex: 7,
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
                                (availabilityPosting.needsPickup &&
                                        availabilityPosting.rangeOfDates)
                                    ? Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        decoration: BoxDecoration(
                                          color: Colors
                                              .deepOrangeAccent.shade700
                                              .withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text(
                                            "Needs pickup",
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
                                  availabilityPosting.availabilityDetails,
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
                                .getUser(availabilityPosting.posterID);
                            if (interlocutor == null) {
                              return;
                            }

                            var currId =
                                Provider.of<UserState>(context, listen: false)
                                    .user
                                    .uid;
                            if (currId != availabilityPosting.posterID) {
                              bool chatExist = await FirestoreService()
                                  .checkIfChatExists(
                                      availabilityPosting.posterID, currId);
                              Chat chat = chatExist
                                  ? await FirestoreService().getChat(
                                      availabilityPosting.posterID, currId)
                                  : Chat(
                                      participants: [
                                          availabilityPosting.posterID,
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
      ),
    );
  }
}

String getDayName(String dateString) {
  // Step 1: Parse the date string into a DateTime object
  final format = DateFormat("MM/dd/yy");
  DateTime date = format.parse(dateString);

  // Step 2: Use DateFormat to format the DateTime object to get the day name abbreviation
  String dayName = DateFormat('EEE')
      .format(date); // 'EEE' returns the abbreviated day of the week

  return dayName;
}
