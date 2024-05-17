import 'package:flutter/material.dart';
import 'package:helping_hand/start_up_scr.dart';
import 'package:helping_hand/themes.dart';
import 'package:provider/provider.dart';
import 'counter.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MainApp(),
    ),
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
      themeMode: ThemeMode.system,
      home: StartupScr(),
    );
  }
}
