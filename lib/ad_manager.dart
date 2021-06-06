import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544~3347511713";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9645685931978775~7776034508"; //TODO CHANGE IOS
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      //return "ca-app-pub-3940256099942544/6300978111"; //test AD
      return "ca-app-pub-9645685931978775/9634188882";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9645685931978775/9634188882";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId2 {
    if (Platform.isAndroid) {
      //return "ca-app-pub-3940256099942544/6300978111"; //test AD
      return "ca-app-pub-9645685931978775/5222093167";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9645685931978775/5222093167";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_INTERSTITIAL_AD_UNIT_ID>";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_REWARDED_AD_UNIT_ID>";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_REWARDED_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
