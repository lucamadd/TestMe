import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:test_me/screens/testme_screen.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../theme_manager.dart';
import 'package:test_me/storage_manager.dart';

class OnBoardingOne extends StatefulWidget {
  final ThemeNotifier theme;

  OnBoardingOne({this.theme});

  @override
  _OnBoardingOneState createState() => _OnBoardingOneState();
}

class _OnBoardingOneState extends State<OnBoardingOne> {
  ThemeNotifier _theme;
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    if (widget.theme != null) {
      _theme = widget.theme;
    }
    super.initState();
  }

  void _onIntroEnd(context) {
    StorageManager.saveData('isFirstTime', 'false');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (_) => TestMeScreen(
              theme: _theme)), //TODO CAMBIARE NULL COL TEMA PASSATO DAL MAIN
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w900),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.transparent,
      imagePadding: EdgeInsets.zero,
    );

    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new ExactAssetImage('graphics/testme_splash_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.transparent,
        pages: [
          PageViewModel(
            titleWidget: Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: DelayedWidget(
                  delayDuration: Duration(milliseconds: 200),
                  animationDuration: Duration(milliseconds: 700),
                  animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                  child: Image.asset(
                    'graphics/head_white.png',
                    height: 80,
                  )),
            ),
            bodyWidget: Column(
              children: [
                DelayedWidget(
                    delayDuration: Duration(milliseconds: 900),
                    animationDuration: Duration(milliseconds: 700),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: Text(
                      AppLocalizations.of(context).intro_page_one_title,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    )),
                DelayedWidget(
                    delayDuration: Duration(milliseconds: 1600),
                    animationDuration: Duration(milliseconds: 700),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
                      child: Text(
                        AppLocalizations.of(context).intro_page_one_body,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ))
              ],
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "",
            bodyWidget: Column(
              children: [
                DelayedWidget(
                    delayDuration: Duration(milliseconds: 500),
                    animationDuration: Duration(milliseconds: 700),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                      child: Text(
                        AppLocalizations.of(context).intro_page_two_body,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    )),
                DelayedWidget(
                    delayDuration: Duration(milliseconds: 1200),
                    animationDuration: Duration(milliseconds: 700),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
                      child: Text(
                        AppLocalizations.of(context).intro_page_two_body2,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    )),
              ],
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            titleWidget: Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: DelayedWidget(
                  delayDuration: Duration(milliseconds: 500),
                  animationDuration: Duration(milliseconds: 700),
                  animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                  child: Image.asset(
                    'graphics/screen1.png',
                    height: MediaQuery.of(context).size.height * 0.5,
                  )),
            ),
            bodyWidget: Column(
              children: [
                DelayedWidget(
                    delayDuration: Duration(milliseconds: 1200),
                    animationDuration: Duration(milliseconds: 700),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                      child: Text(
                        AppLocalizations.of(context).intro_page_three_body,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    )),
                DelayedWidget(
                    delayDuration: Duration(milliseconds: 1900),
                    animationDuration: Duration(milliseconds: 700),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
                      child: Text(
                        AppLocalizations.of(context).intro_page_three_body2,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ))
              ],
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            titleWidget: Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: DelayedWidget(
                  delayDuration: Duration(milliseconds: 500),
                  animationDuration: Duration(milliseconds: 700),
                  animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                  child: Image.asset(
                    'graphics/screen2.png',
                    height: MediaQuery.of(context).size.height * 0.5,
                  )),
            ),
            bodyWidget: Column(
              children: [
                DelayedWidget(
                    delayDuration: Duration(milliseconds: 1200),
                    animationDuration: Duration(milliseconds: 700),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                      child: Text(
                        AppLocalizations.of(context).intro_page_four_body,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    )),
                DelayedWidget(
                    delayDuration: Duration(milliseconds: 1900),
                    animationDuration: Duration(milliseconds: 700),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
                      child: Text(
                        AppLocalizations.of(context).intro_page_four_body2,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ))
              ],
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            titleWidget: Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: DelayedWidget(
                  delayDuration: Duration(milliseconds: 500),
                  animationDuration: Duration(milliseconds: 700),
                  animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                  child: Image.asset(
                    'graphics/screen3.png',
                    height: MediaQuery.of(context).size.height * 0.5,
                  )),
            ),
            bodyWidget: Column(
              children: [
                DelayedWidget(
                    delayDuration: Duration(milliseconds: 1200),
                    animationDuration: Duration(milliseconds: 700),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                      child: Text(
                        AppLocalizations.of(context).intro_page_five_body,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    )),
              ],
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            titleWidget: Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: DelayedWidget(
                  delayDuration: Duration(milliseconds: 500),
                  animationDuration: Duration(milliseconds: 700),
                  animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                  child: Image.asset(
                    'graphics/screen4.png',
                    height: MediaQuery.of(context).size.height * 0.5,
                  )),
            ),
            bodyWidget: Column(
              children: [
                DelayedWidget(
                    delayDuration: Duration(milliseconds: 1200),
                    animationDuration: Duration(milliseconds: 700),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                      child: Text(
                        AppLocalizations.of(context).intro_page_six_body,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    )),
                DelayedWidget(
                    delayDuration: Duration(milliseconds: 2500),
                    animationDuration: Duration(milliseconds: 700),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 30, 16, 0),
                      child: Text(
                        AppLocalizations.of(context).intro_page_six_body2,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    )),
              ],
            ),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        onSkip: () => _onIntroEnd(context),
        skipFlex: 0,
        nextFlex: 0,
        //rtl: true, // Display as right-to-left
        skip: Text(AppLocalizations.of(context).intro_page_skip,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18)),
        next: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
        done: Text(AppLocalizations.of(context).intro_page_done,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18)),
        curve: Curves.easeIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 2.0),
          color: Colors.white,
          activeSize: Size(22.0, 2.0),
          activeColor: Colors.white,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
