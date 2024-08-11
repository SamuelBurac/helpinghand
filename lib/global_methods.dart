import 'package:flutter/material.dart';
import 'package:helping_hand/public_profile/UserPublicProfileScr.dart';
import 'package:helping_hand/services/firestore.dart';

/// Navigates to the user's public profile screen.
///
/// 
Future<void> navigateToUserPublicProfileScr(
    BuildContext context, String pageUID, String currUserUID) async {
  final bool canReview = await leaveReview(currUserUID, pageUID);
  final bool hasReviewed =
      await FirestoreService().hasReviewed(currUserUID, pageUID);

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => UserPublicProfileScr(
        userID: pageUID,
        canReview: canReview,
        hasReviewed: hasReviewed,
      ),
    ),
  );
}

Future<bool> leaveReview(String reveiwer, String reviewee) async {
  if (reveiwer == reviewee) {
    return false;
  }
  final bool hasChat =
      await FirestoreService().checkIfChatExists(reviewee, reveiwer);

  return hasChat;
}
