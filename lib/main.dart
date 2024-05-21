import 'package:flutter/material.dart';
import 'package:helping_hand/services/routes.dart';
import 'package:helping_hand/services/themes.dart';
import 'package:provider/provider.dart';
import 'services/counter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_options.dart';

ThemeMode thema = ThemeMode.system;
//todo change later use provider to add button when time comes

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Flutter Demo',
      theme:lightTheme,
      darkTheme: darkTheme,
      themeMode: thema,
      routes: appRoutes,
      initialRoute: '/',
    );
  }
}
