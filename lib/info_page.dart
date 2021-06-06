import 'dart:io';
import 'dart:typed_data';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:test_me/about_screen.dart';
import 'package:toast/toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool value = false;

  Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
    final Directory output = await getTemporaryDirectory();
    final String screenshotFilePath = '${output.path}/feedback.png';
    final File screenshotFile = File(screenshotFilePath);
    await screenshotFile.writeAsBytes(feedbackScreenshot);
    return screenshotFilePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 30,
                onPressed: () => Navigator.pop(context),
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                AppLocalizations.of(context).info_page_title,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(100.0)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 28, 0, 0),
        child: SettingsList(
          backgroundColor: Colors.white,
          sections: [
            SettingsSection(
              title: AppLocalizations.of(context).info_page_section1,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).primaryColor),
              tiles: [
                SettingsTile.switchTile(
                  title: AppLocalizations.of(context).info_page_setting1,
                  titleTextStyle:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  leading: Icon(
                    Icons.brightness_4_rounded,
                  ),
                  switchValue: false,
                  onToggle: (bool value) {
                    Toast.show(
                        AppLocalizations.of(context)
                            .info_page_toast_not_implemented,
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.BOTTOM);
                  },
                ),
                SettingsTile(
                  title: AppLocalizations.of(context).info_page_setting2,
                  titleTextStyle:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  leading: Icon(Icons.text_snippet_rounded),
                  onPressed: (BuildContext context) {
                    Toast.show(
                        AppLocalizations.of(context)
                            .info_page_toast_not_implemented,
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.BOTTOM);
                  },
                ),
              ],
            ),
            SettingsSection(
              titlePadding: EdgeInsets.fromLTRB(16, 20, 16, 0),
              title: AppLocalizations.of(context).info_page_section2,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).primaryColor),
              tiles: [
                SettingsTile(
                  title: AppLocalizations.of(context).info_page_setting3,
                  titleTextStyle:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  leading: Icon(Icons.feedback),
                  onPressed: (BuildContext context) {
                    BetterFeedback.of(context)?.show(
                        (String feedback, Uint8List feedbackScreenshot) async {
                      // draft an email and send to developer
                      final screenshotFilePath =
                          await writeImageToStorage(feedbackScreenshot);

                      final Email email = Email(
                        body: feedback,
                        subject: '[Feedback] TestMe',
                        recipients: ['lucamadd.dev@gmail.com'],
                        attachmentPaths: [screenshotFilePath],
                        isHTML: false,
                      );
                      await FlutterEmailSender.send(email);
                    });
                  },
                ),
                SettingsTile(
                  title: AppLocalizations.of(context).info_page_setting4,
                  titleTextStyle:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  leading: Icon(Icons.info),
                  onPressed: (BuildContext context) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AboutScreen(),
                        ));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
