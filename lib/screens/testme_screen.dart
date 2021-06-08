import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_me/helpers/database_helper.dart';
import 'package:test_me/info_page.dart';
import 'package:test_me/models/topic_model.dart';
import 'package:test_me/screens/add_row.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_me/theme_manager.dart';

import '../ad_manager.dart';

class TestMeScreen extends StatefulWidget {
  final ThemeNotifier theme;

  TestMeScreen({this.theme});

  @override
  _TestMeScreenState createState() => _TestMeScreenState();
}

class _TestMeScreenState extends State<TestMeScreen> {
  ThemeNotifier _theme;
  Future<List<Topic>> _topicList;
  int _topics = 0;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  // TODO: Add _bannerAd
  BannerAd _bannerAd;

  // TODO: Add _isBannerAdReady
  bool _isBannerAdReady = false;

  @override
  void initState() {
    if (widget.theme != null) {
      _theme = widget.theme;
    }
    super.initState();
    _updateTopicList();
    // TODO: Initialize _bannerAd
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: AdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  _updateTopicList() {
    setState(() {
      _topicList = DatabaseHelper.instance.getTopicList();
    });
  }

  Widget _buildTask(Topic topic) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              topic.title,
              style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  decoration: topic.status == 0
                      ? TextDecoration.none
                      : TextDecoration.lineThrough),
            ),
            subtitle: Text(
                topic.notes.trim().isEmpty
                    ? topic.priority
                    : topic.priority + ' • ' + topic.notes,
                style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    decoration: topic.status == 0
                        ? TextDecoration.none
                        : TextDecoration.lineThrough)),
            trailing: Checkbox(
              onChanged: (value) {
                topic.status = value ? 1 : 0;
                DatabaseHelper.instance.updateTopic(topic);
                _updateTopicList();
              },
              activeColor: Theme.of(context).primaryColor,
              value: topic.status == 1 ? true : false,
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AddRowScreen(
                          updateTopicList: _updateTopicList,
                          topic: topic,
                        ))),
          ),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: _drawerKey,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, 4),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(90),
          gradient:
              LinearGradient(colors: [Color(0xff858df8), Color(0xff5e65f3)]),
        ),
        child: FloatingActionButton.extended(
          highlightElevation: 1,
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: const Icon(
            Icons.menu_book_outlined,
            color: Colors.white,
          ),
          label: const Text(
            'TEST!',
            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
          ),
          onPressed: () async {
            if (_topics == 0) {
              final _snackBar = SnackBar(
                content: Text(
                  AppLocalizations.of(context).testme_screen_snackbar_text,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w700),
                ),
                padding: EdgeInsets.all(5.0),
                duration: Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context).showSnackBar(_snackBar);
            } else {
              var dialogTopic;
              List<Topic> currentTopicList = await _topicList;
              List<Topic> expandedTopicList = <Topic>[];
              for (var i = 0; i < currentTopicList.length; i++) {
                if (currentTopicList[i].priority ==
                    AppLocalizations.of(context).add_row_priorities_3) {
                  expandedTopicList.add(currentTopicList[i]);
                  expandedTopicList.add(currentTopicList[i]);
                } else if (currentTopicList[i].priority ==
                    AppLocalizations.of(context).add_row_priorities_2) {
                  expandedTopicList.add(currentTopicList[i]);
                }
              }
              for (var i = 0; i < currentTopicList.length; i++) {
                expandedTopicList.add(currentTopicList[i]);
              }
              expandedTopicList.shuffle();
              for (var i = 0; i < expandedTopicList.length; i++) {
                if (expandedTopicList[i].status == 0) {
                  dialogTopic = expandedTopicList[i];
                  break;
                }
                if (dialogTopic == null) {
                  dialogTopic = new Topic();
                  dialogTopic.title = AppLocalizations.of(context)
                      .testme_screen_no_topic_available;
                }
              }
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => new AlertDialog(
                        elevation: 9,
                        insetPadding: EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: null,
                        content: Text(
                          dialogTopic.title,
                          style: TextStyle(
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        actions: <Widget>[
                          // TODO: Display a banner when ready
                          if (_isBannerAdReady)
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: _bannerAd.size.width.toDouble(),
                                height: _bannerAd.size.height.toDouble(),
                                child: AdWidget(ad: _bannerAd),
                              ),
                            ),
                          TextButton(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(
                                'OK',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: 'Manrope',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            onPressed: () {
                              dialogTopic.status = 1;
                              DatabaseHelper.instance.updateTopic(dialogTopic);
                              _updateTopicList();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 9.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InfoPage(theme: _theme),
                    ));
              },
            ),
            new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (_) => new AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: null,
                            content: Text(
                              AppLocalizations.of(context)
                                  .testme_screen_confirm_delete,
                              style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .testme_screen_confirm_delete_cancel,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  DatabaseHelper.instance.deleteAllTasks();
                                  _updateTopicList();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .testme_screen_confirm_delete_confirm,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ],
                          )),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddRowScreen(
                          updateTopicList: _updateTopicList,
                        ),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: _topicList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            _topics = snapshot.data.length;
          }

          final int completedTopicCount = snapshot.data
              .where((Topic topic) => topic.status == 1)
              .toList()
              .length;

          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            itemCount: 1 + snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'TestMe',
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 40.0,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        AppLocalizations.of(context).testme_screen_counter(
                            completedTopicCount.toString(),
                            snapshot.data.length.toString()),
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.grey,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      ),
                    ],
                  ),
                );
              }
              return _buildTask(snapshot.data[index - 1]);
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();
    super.dispose();
  }
}
