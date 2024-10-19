import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:helping_hand/services/auth.dart';
import 'models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _jobPostingsCollection = "jobs";
  final String _availabilityPostingsCollection = "availabilities";
  final String _usersCollection = "users";
  final String _chatsCollection = "chats";
  final String _messagesCollection = "messages"; // a subcollection of chats
  final String _reviewsCollection =
      "reviews"; // a subcollection of users one reviews collection per user

  Future<List<JobPosting>> getJobs() async {
    var ref = _db.collection(_jobPostingsCollection);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var jobPostings = data.map((d) => JobPosting.fromJson(d));
    return jobPostings.toList();
  }

  Future<void> addFCMToken(String uid, String token) async {
    if (uid == "") {
      return;
    }
    if (token == "") {
      return;
    }
    // if the token is already in the array, don't add it again
    var doc = await _db.collection(_usersCollection).doc(uid).get();
    var data = doc.data();
    var fcmTokens = data!['fcmTokens'];
    if (fcmTokens.contains(token)) {
      return;
    }
    // otherwise add the token to the array
    await _db.collection(_usersCollection).doc(uid).update({
      'fcmTokens': FieldValue.arrayUnion([token]),
    });
  }

   Future<void> removeFCMToken(String uid, String token) async {
    await _db.collection(_usersCollection).doc(uid).update({
      'fcmTokens': FieldValue.arrayRemove([token]),
    });
  }

  Future<List<String>> getFCMTokens(String uid) async {
    DocumentSnapshot doc = await _db.collection(_usersCollection).doc(uid).get();
    return List<String>.from(doc['fcmTokens'] ?? []);
  }


  Stream<List<JobPosting>> streamJobs(String currUID) {
    var ref = _db
        .collection(_jobPostingsCollection)
        .where('jobPosterID', isEqualTo: currUID);
    var snapshot = ref.snapshots();
    return snapshot.map((list) =>
        list.docs.map((doc) => JobPosting.fromJson(doc.data())).toList());
  }

  Future<List<AvailabilityPosting>> getAvailabilities() async {
    var ref = _db.collection(_availabilityPostingsCollection);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var avaPostings = data.map((d) => AvailabilityPosting.fromJson(d));
    return avaPostings.toList();
  }

  Stream<List<AvailabilityPosting>> streamAvailabilitiesFiltered(
      String currUID) {
    var ref = _db
        .collection(_availabilityPostingsCollection)
        .where('posterID', isEqualTo: currUID);
    var snapshot = ref.snapshots();
    return snapshot.map((list) => list.docs
        .map((doc) => AvailabilityPosting.fromJson(doc.data()))
        .toList());
  }

  //get a users document from the users collection using the user id
  Future<User?> getUser(uid) async {
    var doc = await _db.collection(_usersCollection).doc(uid).get();
    var data = doc.data();
    var user = User.fromJson(data!);
    return user;
  }

  Future<void> addJob(JobPosting jobPosting) async {
    // Add the job posting to the collection and wait for the operation to complete
    DocumentReference docRef =
        await _db.collection(_jobPostingsCollection).add(jobPosting.toJson());

    // Once the document is added, Firestore generates a unique ID, which can be accessed through the DocumentReference
    jobPosting.jobID = docRef.id;

    // Optionally, update the document with the generated ID if needed
    await docRef.update({'jobID': jobPosting.jobID});
  }

  Future<void> addAvailability(AvailabilityPosting avaPosting) async {
    // Add the job posting to the collection and wait for the operation to complete
    DocumentReference docRef = await _db
        .collection(_availabilityPostingsCollection)
        .add(avaPosting.toJson());

    // Once the document is added, Firestore generates a unique ID, which can be accessed through the DocumentReference
    avaPosting.avaPostID = docRef.id;

    // Optionally, update the document with the generated ID if needed
    await docRef.update({'avaPostID': avaPosting.avaPostID});
  }

  Future<void> updateUser(User user) async {
    // Update the user in the collection
    await _db.collection(_usersCollection).doc(user.uid).update(user.toJson());
  }

  Future<bool> checkIfUserExists(String uid) async {
    var doc = await _db.collection(_usersCollection).doc(uid).get();
    return doc.exists;
  }

  Future<void> updateUserPFP(String uid, String url) async {
    // Update the user's name in the collection
    await _db
        .collection(_jobPostingsCollection)
        .where('jobPosterID', isEqualTo: uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.update({'pfpURL': url});
      }
    });

    await _db
        .collection(_availabilityPostingsCollection)
        .where('posterID', isEqualTo: uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.update({'pfpURL': url});
      }
    });
  }

  Future<void> updateUserName(
      String uid, String firstName, String lastName) async {
    // Update the user's name in the collection
    await _db
        .collection(_jobPostingsCollection)
        .where('jobPosterID', isEqualTo: uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.update({'jobPosterName': "$firstName $lastName"});
      }
    });

    await _db
        .collection(_availabilityPostingsCollection)
        .where('posterID', isEqualTo: uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.update({'jobPosterName': "$firstName $lastName"});
      }
    });
  }

  Future<void> updatePostingsRating(String uid, double rating) async {
    // Update the users job and availability postings to reflect the new rating
    await _db
        .collection(_jobPostingsCollection)
        .where('jobPosterID', isEqualTo: uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.update({'rating': rating});
      }
    });
    await _db
        .collection(_availabilityPostingsCollection)
        .where('posterID', isEqualTo: uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.update({'rating': rating});
      }
    });
  }

  Future<void> updateJob(JobPosting jobPosting) async {
    // Update the job posting in the collection
    await _db
        .collection(_jobPostingsCollection)
        .doc(jobPosting.jobID)
        .update(jobPosting.toJson());
  }

  Future<void> updateAvailability(AvailabilityPosting avaPosting) async {
    // Update the job posting in the collection
    await _db
        .collection(_availabilityPostingsCollection)
        .doc(avaPosting.avaPostID)
        .update(avaPosting.toJson());
  }

  Future<void> deleteJob(JobPosting jobPosting) async {
    // Delete the job posting from the collection
    await _db.collection(_jobPostingsCollection).doc(jobPosting.jobID).delete();
  }

  Future<void> deleteAvailability(AvailabilityPosting avaPosting) async {
    // Delete the job posting from the collection
    await _db
        .collection(_availabilityPostingsCollection)
        .doc(avaPosting.avaPostID)
        .delete();
  }

  Future<void> createNewUser(User user) async {
    // Add the user to the collection and wait for the operation to complete
    await _db.collection(_usersCollection).doc(user.uid).set(user.toJson());
  }

  Future<String> uploadProfilePicture(String uid, File image) async {
    // Upload the image to Firebase Storage
    var ref = FirebaseStorage.instance
        .ref()
        .child('profilePics/$uid/${DateTime.now()}.png');
    await ref.putFile(image);
    var url = await ref.getDownloadURL();

    return url;
  }

  Future<void> deleteUser(User user) async {
    // Delete the users job postings from the collection
    await _db
        .collection(_jobPostingsCollection)
        .where('jobPosterID', isEqualTo: user.uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
    // Delete the users availability postings from the collection
    await _db
        .collection(_availabilityPostingsCollection)
        .where('posterID', isEqualTo: user.uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });

    //delete users chats
    await _db
        .collection(_chatsCollection)
        .where('participants', arrayContains: user.uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });

    // Delete the user from the collection
    await _db.collection(_usersCollection).doc(user.uid).delete();
    // Delete all users job postings from the collection
    await _db
        .collection(_jobPostingsCollection)
        .where('jobPosterID', isEqualTo: user.uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });

    // Delete all users availability postings from the collection
    await _db
        .collection(_availabilityPostingsCollection)
        .where('posterID', isEqualTo: user.uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });

    // Delete the users profile picture from Firebase Storage
    FirebaseStorage.instance.refFromURL(user.pfpURL).delete();

    // Delete the user from Firebase Authentication
    try {
      await AuthService().user!.delete();
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        firebase_auth.FirebaseAuth.instance.signOut();
      }
    } catch (e) {
      print("Were cooked $e");
    }
  }

  Future<bool> checkIfChatExists(String uid1, String uid2) async {
    var ref = _db.collection(_chatsCollection);
    var snapshot = await ref.where('participants', arrayContains: uid1).get();

    return snapshot.docs.any((doc) {
      List participants = doc.data()['participants'] as List;
      return participants.contains(uid2);
    });
  }

  Future<void> addChat(Chat chat) async {
    // Add the chat to the collection and wait for the operation to complete
    var ref = await _db.collection(_chatsCollection).add(chat.toJson());
    chat.chatID = ref.id;
    await ref.update({'chatID': chat.chatID});
  }

  Future<void> deleteChat(String chatID) async {
    // Delete the chat from the collection
    await _db.collection(_chatsCollection).doc(chatID).delete();

    //delete images in the chat from storage
    var ref = FirebaseStorage.instance.ref().child('chatImages/$chatID');
    var listResult = await ref.listAll();

    for (var item in listResult.items) {
      await item.delete();
    }
  }

  Stream<List<Chat>> getChats(String uid) {
    // Get the chats from the collection
    var ref = _db
        .collection(_chatsCollection)
        .where('participants', arrayContains: uid);
    var snapshot = ref.snapshots();
    return snapshot.map(
        (list) => list.docs.map((doc) => Chat.fromJson(doc.data())).toList());
  }

  Future<Chat> getChat(String uid1, String uid2) async {
    // Get the chat from the collection
    var ref = _db.collection(_chatsCollection);
    var snapshot = await ref.where('participants', arrayContains: uid1).get();
    var doc = snapshot.docs.firstWhere((doc) {
      List participants = doc.data()['participants'] as List;
      return participants.contains(uid2);
    });
    var data = doc.data();
    var chat = Chat.fromJson(data);
    return chat;
  }

  Future<void> sendMessage(
      String chatID, Message message, String interlocutorUID) async {
    // Add the message to the collection and wait for the operation to complete
    await _db
        .collection(_chatsCollection)
        .doc(chatID)
        .collection('messages')
        .add(message.toJson());
    await _db.collection(_chatsCollection).doc(chatID).update({
      'lastMessageTS': DateTime.now(),
      'lastMessage': message.message,
      'unreadUID': interlocutorUID
    });
  }

  Future<void> messagesRead(String chatID) async {
    await _db
        .collection(_chatsCollection)
        .doc(chatID)
        .update({'unreadUID': ""});
  }

  Stream<List<Message>> getMessages(String chatID) {
    // Get the messages from the collection
    var ref = _db
        .collection(_chatsCollection)
        .doc(chatID)
        .collection(_messagesCollection);
    var snapshot = ref.snapshots();
    return snapshot.map((list) =>
        list.docs.map((doc) => Message.fromJson(doc.data())).toList());
  }

  Future<String> uploadChatImage(String chatID, File image) async {
    // Upload the image to Firebase Storage
    var ref = FirebaseStorage.instance
        .ref()
        .child('chatImages/$chatID/${DateTime.now()}.png');
    await ref.putFile(image);
    var url = await ref.getDownloadURL();

    return url;
  }

  Future<void> addReview(Review review) async {
    User? reviewee = await getUser(review.revieweeID);
    if (reviewee == null) {
      throw Exception("User does not exist");
    }
    double totalRating =
        ((reviewee.rating * reviewee.numReviews) + review.rating) /
            (reviewee.numReviews + 1);

    // Update the user's rating and number of reviews
    await _db.collection(_usersCollection).doc(review.revieweeID).update({
      'rating': totalRating,
      'numReviews': reviewee.numReviews + 1,
    });

    // Add the review to the collection and wait for the operation to complete
    await _db
        .collection(_usersCollection)
        .doc(review.revieweeID)
        .collection(_reviewsCollection)
        .doc(review.reviewerID)
        .set(review.toJson());
  }

  Future<void> updateReview(
      Review oldReview, Review review, User reviewee) async {
    double totalRating = ((reviewee.rating * reviewee.numReviews) +
            review.rating -
            oldReview.rating) /
        (reviewee.numReviews);

    //update users postings
    await updatePostingsRating(reviewee.uid, totalRating);

    // Update the review in the collection
    await _db
        .collection(_usersCollection)
        .doc(review.revieweeID)
        .collection(_reviewsCollection)
        .doc(review.reviewerID)
        .update(review.toJson());

    // Update the user's rating
    await _db.collection(_usersCollection).doc(review.revieweeID).update({
      'rating': totalRating,
    });
  }

  Future<void> deleteReview(Review review, User reviewee) async {
    double totalRating =
        ((reviewee.rating * reviewee.numReviews) - review.rating) /
            (reviewee.numReviews - 1);

    if ((reviewee.numReviews - 1) == 0) {
      totalRating = 0;
    }

    // Update the user's rating and number of reviews
    await _db.collection(_usersCollection).doc(review.revieweeID).update({
      'rating': totalRating,
      'numReviews': reviewee.numReviews - 1,
    });

    // Delete the review from the collection
    await _db
        .collection(_usersCollection)
        .doc(review.revieweeID)
        .collection(_reviewsCollection)
        .doc(review.reviewerID)
        .delete();
  }

  //when called must check if the review not null
  Future<Review?> getReview(String revieweeID, String reviewerID) async {
    var doc = await _db
        .collection(_usersCollection)
        .doc(revieweeID)
        .collection(_reviewsCollection)
        .doc(reviewerID)
        .get();

    if (doc.exists) {
      var data = doc.data();
      var review = Review.fromJson(data!);
      return review;
    } else {
      return null;
    }
  }

  Stream<List<Review>> getReviews(String uid) {
    // Get the reviews from the collection
    var ref = _db
        .collection(_usersCollection)
        .doc(uid)
        .collection(_reviewsCollection);
    var snapshots = ref.snapshots();
    return snapshots.map(
        (list) => list.docs.map((doc) => Review.fromJson(doc.data())).toList());
  }

  Future<bool> hasReviewed(String reveiwerUID, String revieweeUID) async {
    return _db
        .collection(_usersCollection)
        .doc(revieweeUID)
        .collection(_reviewsCollection)
        .where('reviewerID', isEqualTo: reveiwerUID)
        .get()
        .then((snapshot) => snapshot.docs.isNotEmpty);
  }
}
