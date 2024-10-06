import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  BannerAdListener get adListener => _adListener;

  final BannerAdListener _adListener = BannerAdListener(
    // onAdLoaded: (Ad ad) => print('Ad loaded: ${ad.adUnitId}.'),
    // onAdFailedToLoad: (Ad ad, LoadAdError error) {
    //   ad.dispose();
    //   print('Ad failed to load: $error');
    // },
    // onAdOpened: (Ad ad) => print('Ad opened: ${ad.adUnitId}.'),
    // onAdClosed: (Ad ad) => print('Ad closed: ${ad.adUnitId}.'),
  );
}
