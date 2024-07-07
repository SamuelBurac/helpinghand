import 'package:flutter/material.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:helping_hand/UserPublicProfileScr.dart';
import 'package:helping_hand/services/models.dart';
import 'AvailabilityCard.dart';

class AvailabilityListingFScr extends StatelessWidget {
  final AvailabilityPosting avaPosting;

  const AvailabilityListingFScr({required this.avaPosting, super.key});

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
              onTap:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserPublicProfileScr(userID: avaPosting.posterID),
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
                      child: FadeInImage.assetNetwork(
                        placeholder:
                            'assets/emptyProfilePic.png', // Replace with your placeholder asset
                        image: avaPosting.pfpURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(avaPosting.jobPosterName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        AnimatedRatingStars(
                          initialRating: avaPosting.rating,
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
                const Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                Text(
                  avaPosting.generalLocation,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            avaPosting.rangeOfDates
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
                            left: 2.5, right: 2.5, bottom: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0, bottom: 2.0, left: 2.0, right: 6.0),
                          child: Text(
                            " ${avaPosting.startDate!} ${getDayName(avaPosting.startDate!)}",
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
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 2.5, right: 2.5, bottom: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0, bottom: 2.0, left: 2.0, right: 6.0),
                          child: Text(
                            " ${avaPosting.endDate!} ${getDayName(avaPosting.endDate!)}",
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
                      const Text(
                        "Available on: ",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: avaPosting.availabilityDates!
                                .take(3)
                                .map((date) => Container(
                                      margin: const EdgeInsets.only(
                                          left: 2.5, right: 2.5, bottom: 4),
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
                          if (avaPosting.availabilityDates!.length > 3)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: avaPosting.availabilityDates!
                                  .skip(3)
                                  .map((date) => Container(
                                        margin: const EdgeInsets.only(
                                            left: 2.5, right: 2.5, bottom: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.amber.withOpacity(0.6),
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
                    avaPosting.needsPickup
                        ? Container(
                            margin: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color:
                                  Colors.deepOrangeAccent.shade700.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                "Needs Pickup",
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
                      avaPosting.availabilityDetails,
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
        onPressed: () {},
      ),
    );
  }
}