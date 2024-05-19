// Routes for the application
//chats screens
import 'package:helping_hand/Chats_screens/ChatsOverviewScr.dart';
import 'package:helping_hand/Chats_screens/ChatScr.dart';

//onboarding pipeline
import 'package:helping_hand/onboarding_pipeline/SignupScr.dart';
import 'package:helping_hand/onboarding_pipeline/PersonalInfoScr.dart';
import 'package:helping_hand/onboarding_pipeline/ProfileSetupScr.dart';

//job listing pipeline
import 'package:helping_hand/job_listing_pipeline/InputJobScr.dart';
import 'package:helping_hand/job_listing_pipeline/ReviewListingScr.dart';

//person listing pipeline
import '../person_listing_pipeline/InputAvailabilityScr.dart';
import 'package:helping_hand/person_listing_pipeline/ReviewPersonListingScr.dart';

//miscellaneous
import 'package:helping_hand/JobListingFullScr.dart';
import 'package:helping_hand/JobListingsScr.dart';
import 'package:helping_hand/PersonReviewsScr.dart';
import '../StartupScr.dart';
import 'package:helping_hand/UserPublicProfileScr.dart';
import 'package:helping_hand/LoginScr.dart';


var appRoutes = {
  "/": (context) => const StartupScr(),

  "/chatScreen": (context) => const ChatScr(),
  "/chatsOverview": (context) => const ChatsOverviewScr(),
  
  "/inputJob": (context) => const InputJobScr(),
  "/reviewJob": (context) => const ReviewListingScr(),
  
  "/emailSignup": (context) => const EmailSignupScr(),
  "/personalInfo": (context) => const PersonalInfoScr(),
  "/profileSetup": (context) => const ProfileSetupScr(),
  "/inputAvailability": (context) => const InputAvailabilityScr(),
  "/reviewPerson": (context) => const ReviewPersonListingScr(),
  "/jobListings": (context) => const JobListingsScr(),
  "/jobListingFull": (context) => const JobListingFullScr(),
  "/personReviews": (context) => const PersonReviewsScr(),
  "/userPublicProfile": (context) => const UserPublicProfileScr(),
  "/login": (context) => const LoginScr(),
};