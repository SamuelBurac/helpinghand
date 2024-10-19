import 'package:flutter/material.dart';
import 'package:helping_hand/onboarding_pipeline/SignupScr.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/auth.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:provider/provider.dart';

class StartupScr extends StatefulWidget {
  const StartupScr({super.key});

  @override
  State<StartupScr> createState() => _StartupScrState();
}

class _StartupScrState extends State<StartupScr> {
  @override
  Widget build(BuildContext context) {
    double boxSize = MediaQuery.of(context).size.height * 0.3;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                child: Image.asset('assets/acquisition.png'),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(10.0).copyWith(bottom: 25.0),
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: Theme.of(context)
                              .textButtonTheme
                              .style
                              ?.copyWith(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    Colors.grey.shade600),
                                textStyle: WidgetStateProperty.all<TextStyle>(
                                  const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                minimumSize: WidgetStateProperty.all<Size>(
                                    const Size(
                                        0, 50)), // set the height as needed
                              ),
                          child: const Text("Log in"),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          style: Theme.of(context)
                              .textButtonTheme
                              .style
                              ?.copyWith(
                                textStyle: WidgetStateProperty.all<TextStyle>(
                                  const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                minimumSize: WidgetStateProperty.all<Size>(
                                    const Size(
                                        0, 50)), // set the height as needed
                              ),
                          child: const Text("Sign up to work"),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextButton(
                          onPressed: () async {
                            await AuthService().signInWithGoogle();
                            if (!mounted) return;
                            if (await FirestoreService()
                                .checkIfUserExists(AuthService().user!.uid)) {
                                  Provider.of<UserState>(context, listen: false).signedInWithThirdParty = true; 
                              Navigator.popAndPushNamed(context, "/");
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SignupScr(thirdPartySignup: true),
                                ),
                              );
                            }
                          },
                          style: Theme.of(context)
                              .textButtonTheme
                              .style
                              ?.copyWith(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  Colors.indigo.shade700,
                                ),
                                textStyle: WidgetStateProperty.all<TextStyle>(
                                  const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                minimumSize: WidgetStateProperty.all<Size>(
                                    const Size(
                                        0, 50)), // set the height as needed
                              ),
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/google_logo.png',
                                height: 30.0,
                              ), // Add the image
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Center(
                                  child: const Text(
                                    "Sign in with Google",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      // if the platform is iOS, show the Apple sign in button
                      if (Theme.of(context).platform == TargetPlatform.iOS)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextButton(
                            onPressed: () async {
                              // await AuthService().signInWithApple();
                              if (!mounted) return;
                              if (await FirestoreService()
                                  .checkIfUserExists(AuthService().user!.uid)) {
                                Navigator.popAndPushNamed(context, "/");
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SignupScr(thirdPartySignup: true),
                                  ),
                                );
                              }
                            },
                            style: Theme.of(context)
                                .textButtonTheme
                                .style
                                ?.copyWith(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                    Colors.grey.shade900,
                                  ),
                                  textStyle: WidgetStateProperty.all<TextStyle>(
                                    const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  minimumSize: WidgetStateProperty.all<Size>(
                                      const Size(
                                          0, 50)), // set the height as needed
                                ),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/apple_logo.png',
                                  color: Colors.white,
                                  height: 30.0,
                                ), // Add the image
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Center(
                                    child: const Text(
                                      "Sign in with Apple",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
