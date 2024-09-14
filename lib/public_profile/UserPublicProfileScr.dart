//page seen when a user clicks on another user's profile
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:helping_hand/Chats_screens/chat_screen.dart';
import 'package:helping_hand/public_profile/edit_review_card.dart';
import 'package:helping_hand/public_profile/review_card.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:provider/provider.dart';

part 'user_public_profile_controller.dart';

class UserPublicProfileScr extends StatelessWidget {
  final String userID;
  final bool canReview;
  final bool hasReviewed;
  const UserPublicProfileScr(
      {required this.userID,
      required this.canReview,
      required this.hasReviewed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirestoreService().getUser(userID),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              User user = snapshot.data!;
              return ChangeNotifierProvider(
                create: (context) => PublicProfileState(
                    user, Provider.of<UserState>(context, listen: false).user),
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text("${user.firstName} ${user.lastName}"),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Consumer<PublicProfileState>(
                      builder: (context, state, child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 70,
                                  child: user.pfpURL != ""
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: user.pfpURL,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    color: Colors.amber,
                                                    value: downloadProgress
                                                        .progress),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        )
                                      : Image.asset(
                                          "assets/emptyProfilePic.png"),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    RatingStars(
                                      value: state.overallRating,
                                      onValueChanged: (value) {},
                                      starColor: Colors.amber,
                                      
                                    ),
                                    if (user.displayPhoneNumber)
                                      Text(
                                        '(${user.phoneNumber.substring(0, 3)})-${user.phoneNumber.substring(3, 6)}-${user.phoneNumber.substring(6, 10)}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            const Text("Description",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Container(
                              width: double.maxFinite,
                              constraints: const BoxConstraints(
                                maxHeight: 125,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade300,
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: AutoSizeText(
                                  user.description,
                                  style: const TextStyle(
                                    height: 1,
                                    fontSize: 20,
                                  ),
                                  maxLines: 2,
                                  minFontSize:
                                      15, // the minimum font size you want
                                  maxFontSize: 25, // the initial font size
                                ),
                              ),
                            ),
                            const Divider(),
                            (canReview && !hasReviewed && !state.submittedReview)
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Leave a Rating and Review",
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                controller:
                                                    state.reviewController,
                                                decoration:
                                                    const InputDecoration(
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
                                                      shape: WidgetStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
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
                                  )
                                : (hasReviewed || state.submittedReview)
                                    ? EditReviewCard(
                                        revieweeID: userID,
                                        reviewerID: Provider.of<UserState>(
                                                context,
                                                listen: false)
                                            .user
                                            .uid)
                                    : const SizedBox(),
                            const Divider(
                              height: 40,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: FutureBuilder<List<Review>>(
                                    future:
                                        FirestoreService().getReviews(userID),
                                    builder: (context, snapshot) {
                                      // check if there is any data
                                      if (snapshot.hasData) {
                                        List<Review> reviews = snapshot.data!;
                                        if (reviews.isEmpty) {
                                          return const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Text(
                                                  "No reviews yet",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                        return ListView.builder(
                                          itemCount: reviews.length,
                                          itemBuilder: (context, index) {
                                            return ReviewCard(
                                              review: reviews[index],
                                            );
                                          },
                                        );
                                      } else if (snapshot.hasError) {
                                        // display error message
                                        return ErrorWidget(snapshot.error!);
                                      } else {
                                        // return loader widget
                                        return const CircularProgressIndicator(
                                            color: Colors.orange);
                                      }
                                    }),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  floatingActionButton: FloatingActionButton.extended(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // adjust the value as needed
                    ),
                    label: const Text(
                      'Connect',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      DateTime date = DateTime.now();
                      User? interlocutor =
                          await FirestoreService().getUser(userID);
                      if (interlocutor == null) {
                        return;
                      }

                      var currId =
                          Provider.of<UserState>(context, listen: false)
                              .user
                              .uid;
                      if (currId != userID) {
                        bool chatExist = await FirestoreService()
                            .checkIfChatExists(userID, currId);
                        Chat chat = chatExist
                            ? await FirestoreService().getChat(userID, currId)
                            : Chat(
                                participants: [userID, currId],
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
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('User not found'),
                ),
                body: const Center(
                  child: Text('User not found'),
                ),
              );
            }
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Loading...'),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
