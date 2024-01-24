import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/enums.dart';

import '../core/networking/request_result.dart';
import '../core/utils/ADS_HELPER.dart';

abstract class BaseAdsHelper {
  Future<RequestResult<InterstitialAd>> createInterstitialAd();
  void showInterstitialAd();
  Future<RequestResult<RewardedAd>> createRewadedAd();
  void showRewardedAd();
}
class RemoteAdsHelper implements BaseAdsHelper {
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  AdRequest request = const AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );




  @override
  Future<RequestResult<InterstitialAd>> createInterstitialAd() async {
    try {
      if(currentuserdata!=null)
      {
      if ( currentuserdata!.Premiun==false) {

        await InterstitialAd.load(
          adUnitId: AdHelper.interstitialAdUnitId,
          request: request,
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              _interstitialAd = ad;
              print(_interstitialAd==null);
            },
            onAdFailedToLoad: (LoadAdError error) {
              _interstitialAd = null;
              createInterstitialAd();
            },
          ),
        );
        print("is null: ${_interstitialAd==null}");
      }}
      return RequestResult(requestState: RequestState.success, data: _interstitialAd);
    } catch (e) {
      return RequestResult(requestState: RequestState.failed, errorMessage: '$e');
    }
  }

  @override
  void showInterstitialAd() {
    try {
      if (_interstitialAd != null) {
        if (currentuserdata!.Premiun==false) {
        _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
            ad.dispose();
            createInterstitialAd();
          },
          onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
            ad.dispose();
            createInterstitialAd();
          },
        );
        _interstitialAd!.show();
      } }else {
        print("Interstitial ad is null. Please load the ad before trying to show it.");
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Future<RequestResult<RewardedAd>> createRewadedAd()  async {
    try {
      if (_rewardedAd == null) {
        if ( currentuserdata!.Premiun==false) {
        RewardedAd.load(
          adUnitId: AdHelper.rewardedAdUnitId,
          request: AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad) {
              ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                    ad.dispose();
                    _rewardedAd = null;
                  createRewadedAd();
                },
              );


                _rewardedAd = ad;
            },
            onAdFailedToLoad: (err) {
              print('Failed to load a rewarded ad: ${err.message}');
            },
          ),
        );
        print("is null: ${_rewardedAd==null}");
      }}
      return RequestResult(requestState: RequestState.success, data: _rewardedAd);
    } catch (e) {
      return RequestResult(requestState: RequestState.failed, errorMessage: '$e');
    }
  }

  @override
  void showRewardedAd() {
    try {
      if (_rewardedAd != null) {
        if (currentuserdata!.Premiun==false) {
        _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (RewardedAd ad) {
            ad.dispose();
            createRewadedAd();
          },
          onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
            ad.dispose();
            createRewadedAd();
          },
        );

        _rewardedAd!.show(
          onUserEarnedReward: (_, reward) {
            print("User earned reward: ${reward.amount} ${reward.type}");
            // Perform actions when the user earns a reward
          },
        );
      } else {
        print("Rewarded ad is null. Please load the ad before trying to show it.");
      }
    }} catch (e) {
      print('Error: $e');
    }
  }


}


class AdIdhelper {
  static const androidAppId = 'ca-app-pub-8119598167678049~9344142597';
  static const iosAppId = 'ca-app-pub-8119598167678049~2245828306';

}