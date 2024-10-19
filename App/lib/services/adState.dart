import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  String get rewardedAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';

  String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  BannerAdListener get bannerAdListener => _bannerAdListener;
  RewardedAdLoadCallback get rewardedAdLoadCallback => _rewardedAdLoadCallback;

  final RewardedAdLoadCallback _rewardedAdLoadCallback = RewardedAdLoadCallback(
    // Called when an ad is successfully received.
    onAdLoaded: (ad) {
      debugPrint('$ad loaded.');
      // Keep a reference to the ad so you can show it later.
    },
    // Called when an ad request failed.
    onAdFailedToLoad: (LoadAdError error) {
      debugPrint('RewardedAd failed to load: $error');
    },
  );

  final BannerAdListener _bannerAdListener = BannerAdListener(
      // onAdLoaded: (Ad ad) => print('Ad loaded: ${ad.adUnitId}.'),
      // onAdFailedToLoad: (Ad ad, LoadAdError error) {
      //   ad.dispose();
      //   print('Ad failed to load: $error');
      // },
      // onAdOpened: (Ad ad) => print('Ad opened: ${ad.adUnitId}.'),
      // onAdClosed: (Ad ad) => print('Ad closed: ${ad.adUnitId}.'),
      );
}
