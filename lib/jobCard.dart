import 'package:flutter/material.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flip_card/flip_card.dart';
import 'package:auto_size_text/auto_size_text.dart';

class JobCard extends StatelessWidget {
  const JobCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 7 / 3,
      child: Card(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "assets/emptyProfilePic.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text('Name'),
                            ),
                            AnimatedRatingStars(
                              initialRating: 3.5,
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
                        Container(
                          margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: double.infinity,
                          child:const AutoSizeText(
                            'Traffic controller',
                            style: TextStyle(
                              height: 1,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            minFontSize:
                                15, // the minimum font size you want
                            maxFontSize: 25, // the initial font size
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Flexible(flex: 1, child: Row()),
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.only(top: 8, right: 8),
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.045,
                child: FlipCard(
                  fill: Fill.fillBack,
                  direction: FlipDirection.HORIZONTAL,
                  front: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 11, 167, 73),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(7.0),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("\$230"),
                            VerticalDivider(),
                            Text("10Hrs")
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
                    child: const Center(
                      child: Text("\$19/Hr"),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
