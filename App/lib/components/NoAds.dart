import 'package:flutter/material.dart';
import '../components/PremiumPrompt.dart';

class NoAds extends StatelessWidget {
  const NoAds({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PremiumPrompt();
        }));
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            'Ad',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Icon(Icons.not_interested_rounded,
              size: 50, color: Colors.red.withOpacity(0.6)),
        ],
      ),
    );
  }
}
