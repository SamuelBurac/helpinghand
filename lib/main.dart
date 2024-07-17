import 'package:flutter/material.dart';
import 'package:helping_hand/routes.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'services/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


ThemeMode thema = ThemeMode.system;
//todo change later use provider to add button when time comes

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await dotenv.load(fileName: "bruh.env");
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserState(),
      child: const MainApp()
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
      themeMode: thema,
      routes: appRoutes,
      initialRoute: '/',
    );
  }
}
