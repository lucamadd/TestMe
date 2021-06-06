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
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Image.asset('graphics/icon.png', scale: 3),
            ),
            Text('TestMe',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900)),
            Text(
              AppLocalizations.of(context).testme_master_version_info,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 30, 40, 0),
              child: Text(
                AppLocalizations.of(context).info_page_about,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
