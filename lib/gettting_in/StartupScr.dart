import 'package:flutter/material.dart';

class StartupScr extends StatelessWidget {
  const StartupScr({super.key});

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
                child: Image.asset('assets/logoHH.png'),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/jobListings');
                          },
                          child: const Text("Skip")),
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
