//gets name and location from user
//gets phone number and type of user

import 'package:flutter/material.dart';

class PersonalInfoScr extends StatelessWidget {
  const PersonalInfoScr({super.key});

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
              "Welcome to helping hand!",
              style: TextStyle(fontSize: 40.0),
            ),
            const Text(
              "Lets get a little more info to get you started.",
              style: TextStyle(fontSize: 20),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Where are you located?",
                  style: TextStyle(fontSize: 20),
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "ZIP code / City, State",
                    ),
                  ),
                ),
                Text(
                  "This is used to sort jobs based on distance",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
              title: const Text(
                "Looking for work?",
                style: TextStyle(fontSize: 20),
              ),
              controlAffinity: ListTileControlAffinity.trailing,
              value: false,
              onChanged: (bool? value) {
                peeHolder(true);
              },
            ),
            CheckboxListTile(
              title: const Text(
                "Looking for workers?",
                style: TextStyle(fontSize: 20),
              ),
              controlAffinity: ListTileControlAffinity.trailing,
              value: false,
              onChanged: (bool? value) {
                peeHolder(true);
              },
            ),
              ],
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
                        Navigator.pushNamed(context, '/profileSetup');
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

void peeHolder(bool pee) {
  print("bruh");
}

mixin val {}
