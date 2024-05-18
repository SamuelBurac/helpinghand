import 'package:flutter/material.dart';

class StartupScr extends StatelessWidget {
  const StartupScr({super.key});

  @override
  Widget build(BuildContext context) {
    double boxSize = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              "Helping Hand",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: MediaQuery.of(context).size.width *
                        0.15, // 5% of screen width
                  ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              width: boxSize,
              height: boxSize,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(boxSize * 0.1), // 10% of the box size
                child: Image.asset('assets/logoHH.png'),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/emailSignup');
                  //sign up
                },
                style: Theme.of(context).textButtonTheme.style,
                child: const Text("Sign up to work"),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextButton(
                onPressed: () {
                  //login
                },
                style: Theme.of(context).textButtonTheme.style?.copyWith(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.grey.shade800),
                ),
                child: const Text("Log in"),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
