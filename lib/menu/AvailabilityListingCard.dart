import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:helping_hand/AvailabilityListingFiles/AvailabilityListingFScr.dart';
import 'package:helping_hand/availability_listing_pipeline/InputAvailabilityScr.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:intl/intl.dart';

class AvailabilityListingCard extends StatelessWidget {
  final AvailabilityPosting availabilityPosting;

  const AvailabilityListingCard({required this.availabilityPosting, super.key});

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
              child:
                  LayoutBuilder(builder: (context, BoxConstraints constraints) {
                return Column(
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
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(availabilityPosting.jobPosterName,
                                    style: const TextStyle(
                                        fontSize: 16,
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
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  minFontSize:
                                      10, // the minimum font size you want
                                  maxFontSize: 25, // the initial font size
                                ),
                              ],
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
                                    fontSize: 13,
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
                                    padding: const EdgeInsets.all(2),
                                    child: Text(
                                      " ${availabilityPosting.endDate!} ${getDayName(availabilityPosting.endDate!)}",
                                      style: const TextStyle(
                                        fontSize: 13,
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
                                const Text(
                                  "Available on: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: availabilityPosting
                                          .availabilityDates!
                                          .take(3)
                                          .map((date) => Container(
                                                height:
                                                    constraints.maxHeight * 0.1,
                                                width: constraints.maxWidth *
                                                    0.237,
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
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                  height:
                                                      constraints.maxHeight *
                                                          0.1,
                                                  width: constraints.maxWidth *
                                                      0.237,
                                                  margin: const EdgeInsets.only(
                                                      left: 2.5,
                                                      right: 2.5,
                                                      bottom: 4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.amber
                                                        .withOpacity(0.6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
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
                                                        fontSize: 10,
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
                      child: Column(
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
                              availabilityPosting.needsPickup
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
                                        padding: EdgeInsets.only(
                                            top: 2.0,
                                            bottom: 2.0,
                                            left: 5.0,
                                            right: 5.0),
                                        child: Text(
                                          "Needs pickup",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: constraints.maxWidth * 0.41,
                                height: constraints.maxHeight * 0.25,
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
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth * 0.2,
                                  maxHeight: constraints.maxHeight * 0.25,
                                ),
                                child: ElevatedButton(
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style!
                                      .copyWith(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color?>(
                                                Colors
                                                    .greenAccent.shade700),
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // adjust the value as needed
                                          ),
                                        ),
                                      ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            InputAvailabilityScr(
                                          editingAvailability: true,
                                          avaEditPosting:
                                              availabilityPosting,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth * 0.3,
                                  maxHeight: constraints.maxHeight * 0.25,
                                ),
                                child: ElevatedButton.icon(
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style!
                                      .copyWith(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color?>(
                                                Colors.red),
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // adjust the value as needed
                                          ),
                                        ),
                                      ),
                                  label: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: const Text(
                                      'Remove',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ),
                                  onPressed: () => FirestoreService()
                                      .deleteAvailability(
                                          availabilityPosting),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
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
