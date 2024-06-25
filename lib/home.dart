import 'package:flutter/material.dart';
import 'package:helping_hand/AvailabilityListingsScr.dart';
import 'package:helping_hand/JobListingsScr.dart';
import 'package:helping_hand/LoadingScreen.dart';
import 'package:helping_hand/gettting_in/StartupScr.dart';
import 'package:helping_hand/error.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/auth.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: ErrorMessage(),
          );
        } else if (snapshot.hasData) {
          return FutureBuilder(
              future: FirestoreService().getUser(snapshot.data!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingScreen();
                } else if (snapshot.hasError) {
                  return ErrorMessage(message: snapshot.error.toString());
                } else if (snapshot.hasData) {
                  var user = snapshot.data as User;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Provider.of<UserState>(context, listen: false).user = user;
                  });
                  return user.lookingForWork
                      ? const JobListingsScr()
                      : const AvailabilityListingsScr();
                } else {
                  return const ErrorMessage(
                      message: "You are not logged in. What the nuts?");
                }
              });
        } else {
          return const StartupScr();
        }
      },
    );
  }
}
