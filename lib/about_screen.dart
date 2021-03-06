import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Image.asset('graphics/icon.png', scale: 3),
              ),
              Text('TestMe',
                  style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900)),
              Text(
                AppLocalizations.of(context).testme_master_version_info,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).accentColor),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 30, 40, 40),
                child: Text(
                  AppLocalizations.of(context).info_page_about,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).accentColor),
                ),
              ),
              Text('SupportMe',
                  style:
                      TextStyle(fontSize: 28.0, fontWeight: FontWeight.w900)),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 10, 40, 30),
                child: Text(
                  AppLocalizations.of(context).info_page_about_support,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).accentColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
