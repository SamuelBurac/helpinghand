import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _jobPostingsCollection = "jobs";
  final String _availabilityPostingsCollection = "availabilities";
  final String _usersCollection = "users";

  Future<List<JobPosting>> getJobs() async {
    var ref = _db.collection(_jobPostingsCollection);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var jobPostings = data.map((d) => JobPosting.fromJson(d));
    return jobPostings.toList();
  }

  Stream<List<JobPosting>> streamJobs(String currUID) {
    var ref = _db.collection(_jobPostingsCollection).where('jobPosterID', isEqualTo: currUID);
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

  Stream<List<AvailabilityPosting>> streamAvailabilitiesFiltered(String currUID) {
    var ref = _db.collection(_availabilityPostingsCollection).where('posterID', isEqualTo: currUID);
    var snapshot = ref.snapshots();
    return snapshot.map((list) =>
        list.docs.map((doc) => AvailabilityPosting.fromJson(doc.data())).toList());
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
    DocumentReference docRef =
        await _db.collection(_availabilityPostingsCollection).add(avaPosting.toJson());

    // Once the document is added, Firestore generates a unique ID, which can be accessed through the DocumentReference
    avaPosting.avaPostID = docRef.id;

    // Optionally, update the document with the generated ID if needed
    await docRef.update({'avaPostID': avaPosting.avaPostID});
  }

  Future<void> updateUser(User user) async {
    // Update the user in the collection
    await _db.collection(_usersCollection).doc(user.uid).update(user.toJson());
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
    await _db.collection(_availabilityPostingsCollection).doc(avaPosting.avaPostID).delete();
  }



}
