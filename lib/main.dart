import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:test_me/onBoarding_one/onboarding_one.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_me/screens/testme_screen.dart';
import 'package:test_me/storage_manager.dart';
import 'package:test_me/theme_manager.dart';

void main() {
  return runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => new ThemeNotifier(),
    child: BetterFeedback(child: MyApp()),
  ));
}

ThemeData buildTheme() {
  final ThemeData base = ThemeData();
  return base.copyWith(
    hintColor: Colors.red,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.yellow, fontSize: 24.0),
    ),
  );
}

class MyApp extends StatelessWidget {
  String isFirstTime;

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    StorageManager.readData('isFirstTime').then((value) {
      print('value read from storage: ' + value.toString());
      isFirstTime = value ?? 'true';
      print("IS FIRST TIME" + isFirstTime.toString());
    });
    /*
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).canvasColor,
      statusBarIconBrightness: Brightness.dark,
    ));
    */
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'TestMe',
        debugShowCheckedModeBanner: false,
        theme: theme.getTheme(),
        home: isFirstTime == 'false'
            ? TestMeScreen(theme: theme)
            : OnBoardingOne(theme: theme),
      ),
    );
  }
}
