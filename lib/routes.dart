// Routes for the application
//chats screens
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/AvailabilityListingFiles/AvailabilityListingsScr.dart';
import 'package:helping_hand/Chats_screens/ChatsOverviewScr.dart';
import 'package:helping_hand/Chats_screens/ChatScr.dart';
import 'package:helping_hand/gettting_in/ForgotPassScr.dart';
import 'package:helping_hand/home.dart';

//onboarding pipeline
import 'package:helping_hand/onboarding_pipeline/SignupScr.dart';
import 'package:helping_hand/onboarding_pipeline/ProfileSetupScr.dart';
import 'package:helping_hand/onboarding_pipeline/CongratsScr.dart';

//job listing pipeline
import 'package:helping_hand/job_listing_pipeline/InputJobScr.dart';

//person listing pipeline
import 'availability_listing_pipeline/InputAvailabilityScr.dart';

//miscellaneous
import 'package:helping_hand/jobListingFiles/JobListingsScr.dart';
import 'package:helping_hand/PersonReviewsScr.dart';
import 'gettting_in/StartupScr.dart'; 
import 'package:helping_hand/UserPublicProfileScr.dart';
import 'package:helping_hand/gettting_in/LoginScr.dart';
import 'package:helping_hand/MenuScr.dart';


var appRoutes = {
  "/": (context) => const HomeScreen(),
  "/startup": (context) => const StartupScr(),
  "/forgotPass": (context) =>  const ForgotPassScreen(),

  "/chatScreen": (context) => const ChatScr(),
  "/chatsOverview": (context) => const ChatsOverviewScr(),
  
  "/inputJob": (context) => const InputJobScr(),
  
  "/signup": (context) => const SignupScr(),
  "/profileSetup": (context) => ProfileSetupScr(docRef: ModalRoute.of(context)!.settings.arguments as DocumentReference),

  "/inputAvailability": (context) => const InputAvailabilityScr(),

  "/jobListings": (context) => const JobListingsScr(),
  "/availabilityListings": (context) => const AvailabilityListingsScr(),
  "/personReviews": (context) => const PersonReviewsScr(),
  "/userPublicProfile": (context) => const UserPublicProfileScr(),
  "/login": (context) =>  const LoginScr(),
  "/congrats": (context) => const CongratsScr(),
  "/menu": (context) => const MenuScr(),
};
