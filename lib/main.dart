import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:test_me/onBoarding_one/onboarding_one.dart';
import 'package:feedback/feedback.dart';
import 'package:test_me/screens/testme_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_me/helpers/utils.dart';
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
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        home: TestMeScreen(theme: theme),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
