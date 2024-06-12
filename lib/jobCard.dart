import 'package:flutter/material.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flip_card/flip_card.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:helping_hand/JobListingFullScr.dart';
import 'package:helping_hand/services/models.dart';

class JobCard extends StatelessWidget {
  JobPosting jobPosting;

  JobCard(
        {required this.jobPosting,         
        super.key});

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          flex: 3,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 35,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        'assets/emptyProfilePic.png', // Replace with your placeholder asset
                                    image: jobPosting.pfpURL,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(jobPosting.jobPosterName,
                                      style: const TextStyle(
                                        fontSize: 14,
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
                                    starSize: 10,
                                  )
                                ],
                              ),
                            ],
                          )),
                      VerticalDivider(
                        color: Colors.grey.shade300,
                        width: 10,
                        endIndent: 10,
                      ),
                      Flexible(
                        flex: 2,
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
                        flex: 2,
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
                            Text(jobPosting.jobLocation),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: jobPosting.canPickup
                            ? Container(
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent.shade700
                                      .withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
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
                      ),
                      Flexible(
                        flex: 5,
                        child: Table(
                          border: TableBorder.symmetric(
                            inside: BorderSide(
                              color: Colors.blueGrey.shade200,
                              width: 2,
                            ),
                          ),
                          children: [
                            TableRow(
                              children: [
                                const Text(
                                  "Start time",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  jobPosting.jobStartTime,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Text(
                                  "End time",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  jobPosting.jobEndTime,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
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
                          const Text(
                            "Details:",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 250,
                            height: 54,
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
                        onPressed: () {},
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
