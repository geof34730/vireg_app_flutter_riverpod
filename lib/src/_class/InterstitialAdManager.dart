import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../global.dart';
import '../_utils/logger.dart';

class InterstitialAdManager {
  static final InterstitialAdManager _instance = InterstitialAdManager._internal();
  InterstitialAd? _interstitialAd;
  DateTime secondLastInterstitialShow=DateTime.now();
  factory InterstitialAdManager() {
    return _instance;
  }

  InterstitialAdManager._internal() {
    loadInterstitialAd();
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
     //return "ca-app-pub-3940256099942544/1033173712";//TEST
      return 'ca-app-pub-1439580806237607/9344280622';//PROD
    } else if (Platform.isIOS) {
      //return "ca-app-pub-3940256099942544/4411468910";//TEST
      return 'ca-app-pub-1439580806237607/4979062574';//PROD
    } else {
      Logger.Red.log("Unsupported platform");
      throw UnsupportedError("Unsupported platform");
    }
  }

  void loadInterstitialAd() {
    if (!kIsWeb) {
      InterstitialAd.load(
        adUnitId: interstitialAdUnitId, // Replace with your own ad unit ID
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('InterstitialAd loaded.');
            _interstitialAd = ad;
            //this.showInterstitialAd();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ),
      );
    }
  }

  void showInterstitialAd() {
    if (!kIsWeb) {
      bool showInterstitialByTime = true;
      if (secondLastInterstitialShow != null) {
        if (DateTime
            .now()
            .difference(secondLastInterstitialShow!)
            .inSeconds < timeSecondLastInterstitialShow) {
          showInterstitialByTime = false;
        }
      }

      if (showInterstitialByTime) {
        if (_interstitialAd != null) {
          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
                onAdDismissedFullScreenContent: (InterstitialAd ad) {
                  print('InterstitialAd dismissed.');
                  ad.dispose();
                  secondLastInterstitialShow = DateTime.now();
                  loadInterstitialAd(); // Preload a new ad
                },
                onAdFailedToShowFullScreenContent: (InterstitialAd ad,
                    AdError error) {
                  print('InterstitialAd failed to show: $error');
                  ad.dispose();
                },
              );
          _interstitialAd!.show();
          _interstitialAd = null;
        } else {
          print('InterstitialAd is not ready yet.');
        }
      }
    }
  }
}
