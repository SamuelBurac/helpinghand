import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';
import 'models.dart';
import 'package:rxdart/rxdart.dart';

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

  
}