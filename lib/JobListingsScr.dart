import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

class JobListingsScr extends StatelessWidget {
  const JobListingsScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Listings'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: jobListings.length,
        itemBuilder: (context, index) {
          final job = jobListings[index];
          return JobCard(job: job);
        },
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              job.company,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              job.location,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 10),
            Text(job.description),
            ElevatedButton(
                onPressed: () {
                  try {
                    FirebaseAuth.instance.signOut();
                  } catch (e) {
                    print('Failed to sign out: $e');
                  }
                },
                child: Text("Logout")),
          ],
        ),
      ),
    );
  }
}
