import 'package:flutter/material.dart';
import 'package:helping_hand/JobListingsScr.dart';
import 'package:helping_hand/LoadingScreen.dart';
import 'package:helping_hand/gettting_in/StartupScr.dart';
import 'package:helping_hand/error.dart';
import 'package:helping_hand/services/auth.dart';

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
          return const JobListingsScr();
        } else {
          return const StartupScr();
        }
      },
    );
  }
}