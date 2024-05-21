import 'package:flutter/material.dart';

class CongratsScr extends StatelessWidget {
  const CongratsScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Congratulations!'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Flexible(flex: 1, child: SizedBox(height: 20)),
            const Flexible(
              flex: 3,
              child: Text(
                '🎉 You\'re all setup 🎉\nLets get to work!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Flexible(flex: 2, child: SizedBox(height: 20)),
            Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/jobListings');
                  },
                  child: const Column(
                    children: [
                      Text(
                        'Continue',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 40,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
