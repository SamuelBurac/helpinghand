import 'package:flutter/material.dart';

class LoginScr extends StatelessWidget {
  const LoginScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login Screen",
                style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // _getJoke();
                },
                child: const Text('Get a Joke'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}