import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _jobPostingsCollection = "jobs";
  final String _availabilityPostingsCollection = "availabilityPostings";
  final String _usersCollection = "users";

  //get a users document from the users collection using the user id
  Future<List<JobPosting>> getJobs() async {
    var ref = _db.collection(_jobPostingsCollection);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var jobPostings = data.map((d) => JobPosting.fromJson(d));
    return jobPostings.toList();
  }

  Future<User?> getUser(uid) async {
    var doc = await _db.collection(_usersCollection).doc(uid).get();
    var data = doc.data();
    var user = User.fromJson(data!);
    return user;
  }
}
