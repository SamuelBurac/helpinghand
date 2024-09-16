import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/error.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:provider/provider.dart';
part 'edit_review_card_controller.dart';

class EditReviewCard extends StatelessWidget {
  final String revieweeID;
  final String reviewerID;
  const EditReviewCard(
      {required this.revieweeID, required this.reviewerID, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreService().getReview(revieweeID, reviewerID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: "Error ${snapshot.error}"),
          );
        } else if (snapshot.hasData) {
          Review review = snapshot.data!;
           return ChangeNotifierProvider(
            create: (context) => EditReviewCardController(review),
            child: Consumer(
              builder: (context, EditReviewCardController state, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Edit your Review",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AnimatedRatingStars(
                      initialRating: review.rating,
                      readOnly: false,
                      onChanged: (value) {
                        state.rating = value;
                      },
                      emptyColor: const Color.fromARGB(255, 157, 157, 157),
                      customFilledIcon: Icons.star,
                      customHalfFilledIcon: Icons.star_half,
                      customEmptyIcon: Icons.star_border,
                      starSize: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: state.reviewController,
                              decoration: const InputDecoration(
                                hintText: "Write a review",
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: ElevatedButton(
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style!
                                  .copyWith(
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                              onPressed: state.submitReview,
                              child: const Text("Submit"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        } else {
          return const Text("Should have a review ");
        }
      },
    );
  }
}
