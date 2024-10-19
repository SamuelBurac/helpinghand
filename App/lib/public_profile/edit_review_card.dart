import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/error.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:provider/provider.dart';
part 'edit_review_card_controller.dart';

class EditReviewCard extends StatelessWidget {
  final User reviewee;
  final String reviewerID;
  final VoidCallback onDelete;
  const EditReviewCard(
      {required this.reviewee,
      required this.reviewerID,
      required this.onDelete,
      super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreService().getReview(reviewee.uid, reviewerID),
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
                return state.isSubmitting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Edit your Review",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  AnimatedRatingStars(
                                    initialRating: state.rating,
                                    readOnly: false,
                                    onChanged: (value) {
                                      state.rating = value;
                                    },
                                    emptyColor: const Color.fromARGB(
                                        255, 157, 157, 157),
                                    customFilledIcon: Icons.star,
                                    customHalfFilledIcon: Icons.star_half,
                                    customEmptyIcon: Icons.star_border,
                                    starSize: 25,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: IconButton(
                                  icon:
                                      const Icon(Icons.delete_forever_rounded),
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style!
                                      .copyWith(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                Colors.red),
                                      ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Delete Review"),
                                          content: const Text(
                                              "Are you sure you want to delete your review?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              style: Theme.of(context)
                                                  .textButtonTheme
                                                  .style!
                                                  .copyWith(
                                                    backgroundColor:
                                                        WidgetStateProperty.all<
                                                            Color>(Colors.red),
                                                  ),
                                              onPressed: () async {
                                                FirestoreService().deleteReview(
                                                    review, reviewee);
                                                onDelete();
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: TextField(
                                    maxLines: 3,
                                    controller: state.reviewController,
                                    decoration: const InputDecoration(
                                      hintText: "Write a review",
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: ElevatedButton(
                                    style: Theme.of(context)
                                        .elevatedButtonTheme
                                        .style!
                                        .copyWith(
                                          shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                    onPressed: () async {
                                      state.submitReview(reviewee);
                                    },
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
          return Text("Should have a review $reviewerID ${reviewee.uid}");
        }
      },
    );
  }
}
