//setup profile page
//profile picture
//description of previous experience
//description of what you are looking for
//avialability

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class ProfileSetupScr extends StatefulWidget {
  final DocumentReference docRef;
  const ProfileSetupScr({required this.docRef, super.key});

  @override
  State<ProfileSetupScr> createState() => _ProfileSetupScrState();
}

class _ProfileSetupScrState extends State<ProfileSetupScr> {
  final descriptionController = TextEditingController();
  File? _selectedImage;
  bool _displayPhoneNumber = false;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0).copyWith(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "Setup your profile",
                style: TextStyle(fontSize: 40.0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Profile picture",
                    style: TextStyle(fontSize: 20),
                  ),
                  InkWell(
                    onTap: () async {
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);

                      if (pickedFile != null) {
                        setState(() {
                          _selectedImage = File(pickedFile.path);
                        });
                      } else {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title:
                                const Text('You must select a profile picture'),
                            content: const Text(
                                'You need a profile picture to continue.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 35,
                          child: _selectedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset("assets/emptyProfilePic.png"),
                        ),
                        const Text(
                          "Lets add a profile picture",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Description of previous experience",
                    style: TextStyle(fontSize: 20),
                  ),
                  Flexible(
                    child: TextField(
                        controller: descriptionController,
                        minLines: 4,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .grey), // Change this color to your desired color
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .orange), // Change this color to your desired color
                          ),
                          hintText:
                              "Talk about your previous experiences, the work that you do, or any other information you want to share to future connections.",
                        )),
                  ),
                ],
              ),
              CheckboxListTile(
                title: const Text(
                  "Display phone number on profile so that people can contact you?",
                  style: TextStyle(fontSize: 17),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                value: _displayPhoneNumber,
                activeColor: Colors.orange,
                onChanged: (bool? value) {
                  setState(() {
                    _displayPhoneNumber = value!;
                  });
                },
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
                        onPressed: () async {
                          String storageURL = "";
                          DocumentReference docRef = widget.docRef;
                          final userID = FirebaseAuth.instance.currentUser!.uid;

                          final storageRef = FirebaseStorage.instance.ref();

                          final profilePicRef = storageRef.child(
                              'profilePics/$userID.${Path.extension(_selectedImage!.path)}');

                          try {
                            await profilePicRef.putFile(_selectedImage!);
                          } catch (e) {
                            SnackBar(content: Text("Error uploading image$e"));
                          }

                          storageURL = await profilePicRef.getDownloadURL();

                          docRef.update({
                            "description": descriptionController.text,
                            "displayPhoneNumber": _displayPhoneNumber,
                            "pfpURL": storageURL,
                          });

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
      ),
    );
  }
}
