import 'package:flutter/material.dart';

class EmailSignupScr extends StatelessWidget {
  const EmailSignupScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back, size: 34.0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Sign up",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'First Name',
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Last Name',
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Phone Number',
                  ),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Password',
                  ),
                ),
              ],
            ),
            TextButton(
                onPressed: () {
                  //login
                },
                style: Theme.of(context).textButtonTheme.style?.copyWith(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.grey.shade600),
                ),
                child: const Text("Already a member? Log in"),
              ),
              SizedBox(
                child: TextButton(
                  onPressed: () {
                    //login
                  },
                  style: Theme.of(context).textButtonTheme.style,
                  child: const Text("Create Account"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
