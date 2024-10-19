import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/adState.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:provider/provider.dart';

class ListingPremiumPrompt extends StatefulWidget {
  final String nextRoute;
  const ListingPremiumPrompt({required this.nextRoute, super.key});

  @override
  State<ListingPremiumPrompt> createState() => _ListingPremiumPromptState();
}

class _ListingPremiumPromptState extends State<ListingPremiumPrompt> {
  RewardedAd? _rewardedAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadAd();
  }

  void loadAd() {
    RewardedAd.load(
        adUnitId: Provider.of<AdState>(context, listen: false).rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _rewardedAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.yellow, Colors.deepOrange],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No more free posts left!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: () {
                    _rewardedAd?.show(onUserEarnedReward: (ad, reward) async {
                      Provider.of<UserState>(context, listen: false)
                          .incrementPostsLeft();
                      await FirestoreService().updateUser(
                          Provider.of<UserState>(context, listen: false).user);
                      Navigator.of(context)
                          .pushReplacementNamed(widget.nextRoute);
                    });
                  },
                  icon: const Icon(Icons.movie_outlined, color: Colors.amber),
                  label: const Text('Watch Ad for 3 more posts'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement premium purchase logic
                  },
                  icon: const Icon(Icons.star, color: Colors.deepOrange),
                  label: const Text('Buy Premium for \$1.99/month'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Unlock more features and turn off ads!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
