import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/services/models.dart';
import 'package:intl/intl.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({required this.review, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.5, bottom: 2.5),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 170),
        
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 150, 160, 156),
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AnimatedRatingStars(
                  initialRating: review.rating,
                  readOnly: true,
                  onChanged: (value) {
                    // is static here
                  },
                  emptyColor: const Color.fromARGB(255, 255, 255, 255),
                  customFilledIcon: Icons.star,
                  customHalfFilledIcon: Icons.star_half,
                  customEmptyIcon: Icons.star_border,
                  starSize: 17,
                ),
                review.reviewerPfpURL.isEmpty
                    ? const Icon(Icons.account_circle)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                          imageUrl: review.reviewerPfpURL,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      color: Colors.amber,
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.account_circle),
                        ),
                      ),
                Text(
                  review.reviewerName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat("MM/dd/yy").format(review.reviewDate),
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            Text(
              review.reviewText,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
