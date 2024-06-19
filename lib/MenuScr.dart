import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuScr extends StatelessWidget {
  const MenuScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(child: Text("log out"),
      onPressed: () {
        FirebaseAuth.instance.signOut();
        Navigator.pushNamed(context, "/startup");
      } 
      ),
    );
  }
}