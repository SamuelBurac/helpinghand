//setup profile page
//profile picture
//description of previous experience
//description of what you are looking for
//avialability

import 'package:flutter/material.dart';

class ProfileSetupScr extends StatelessWidget {
  const ProfileSetupScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              "Setup your profile",
              style: TextStyle(fontSize: 40.0),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Profile picture",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 35,
                      child: Image(
                          image: AssetImage("assets/emptyProfilePic.png")),
                    ),
                    Text(
                      "Lets add a profile picture",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )
              ],
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Description of previous experience",
                  style: TextStyle(fontSize: 20),
                ),
                Flexible(
                  child: TextField(
                      minLines: 4,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText:
                            "Talk about your previous experiences. Tools and technologies you have worked with.",
                      )),
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text(
                "Display phone number on profile so that people can contact you?",
                style: TextStyle(fontSize: 20),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: false,
              onChanged: (bool? value) {},
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/congrats');
                      },
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
