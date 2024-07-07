// page seen when click on another user's profile
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';

class UserPublicProfileScr extends StatelessWidget {
  final String userID;
  const UserPublicProfileScr({required this.userID, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirestoreService().getUser(userID),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              User user = snapshot.data!;
              return Scaffold(
                appBar: AppBar(
                  title: Text("${user.firstName} ${user.lastName}"),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 70,
                                  child: user.pfpURL != ""
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            user.pfpURL,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Image.asset(
                                          "assets/emptyProfilePic.png"),
                                ),
                      user.displayPhoneNumber
                          ? Text(
                              'Phone number: (${user.phoneNumber.substring(0, 3)})-${user.phoneNumber.substring(3, 6)}-${user.phoneNumber.substring(6, 10)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Placeholder(),
                      const Divider(),
                      const Text("Description",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      Container(
                        width: double.maxFinite,
                        height: 125,
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
                            minFontSize: 15, // the minimum font size you want
                            maxFontSize: 25, // the initial font size
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Row(
                          children: [
                            const Text(
                              "Reviews ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AnimatedRatingStars(
                              initialRating: user.rating,
                              readOnly: true,
                              onChanged: (value) {
                                // is static here
                              },
                              emptyColor:
                                  const Color.fromARGB(255, 157, 157, 157),
                              customFilledIcon: Icons.star,
                              customHalfFilledIcon: Icons.star_half,
                              customEmptyIcon: Icons.star_border,
                              starSize: 20,
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListView.builder(
                            itemCount: 3, //user.reviews.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 2.5, bottom: 2.5),
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 150, 160, 156),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          AnimatedRatingStars(
                                            initialRating: user.rating,
                                            readOnly: true,
                                            onChanged: (value) {
                                              // is static here
                                            },
                                            emptyColor:
                                                Color.fromARGB(255, 255, 255, 255),
                                            customFilledIcon: Icons.star,
                                            customHalfFilledIcon: Icons.star_half,
                                            customEmptyIcon: Icons.star_border,
                                            starSize: 17,
                                          ),
                                          const Icon(Icons.account_circle),
                                          const Text("User Name"),
                                          const Text("07/07/2024")
                                        ],
                                      ),
                                      const Divider(),
                                      const Text(
                                        "This dude is awesome!",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
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
                  onPressed: () {},
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
