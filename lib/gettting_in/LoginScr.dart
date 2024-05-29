import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScr extends StatefulWidget {
  const LoginScr({super.key});

  @override
  _LoginScrState createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _errorMessage = '';

  Future<void> _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.of(context).pushNamed('/');
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Log in',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 20),
             Row(
              children: [
                const Text(
                  "Don't have an account?  ",
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(color: Colors.orange, fontSize: 16),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _signIn,
                  child: const Text('Sign In'),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/forgotPass');
                  },
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
