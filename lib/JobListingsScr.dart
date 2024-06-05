import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'JobCard.dart';
//maybe use https://api.flutter.dev/flutter/material/BottomSheet-class.html

// Define a Job model
class Job {
  final String title;
  final String company;
  final String location;
  final String description;

  Job({
    required this.title,
    required this.company,
    required this.location,
    required this.description,
  });
}

// Sample job listings
final List<Job> jobListings = [
  Job(
    title: 'Software Engineer',
    company: 'Tech Co.',
    location: 'San Francisco, CA',
    description: 'Develop and maintain software applications.',
  ),
  Job(
    title: 'Product Manager',
    company: 'Business Inc.',
    location: 'New York, NY',
    description: 'Oversee product development from conception to launch.',
  ),
  // Add more job listings here
];




class JobListingsScr extends StatefulWidget {
  

  const JobListingsScr({
    super.key,
    
  });

  @override
  State<JobListingsScr> createState() => _JobListingsScrState();
}

class _JobListingsScrState extends State<JobListingsScr> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs available"),
      ),
      body: ListView(children: const [JobCard(), JobCard(), JobCard()]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

