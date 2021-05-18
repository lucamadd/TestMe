import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_me/helpers/database_helper.dart';
import 'package:test_me/models/topic_model.dart';
import 'package:test_me/screens/add_row.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestMeScreen extends StatefulWidget {
  @override
  _TestMeScreenState createState() => _TestMeScreenState();
}

class _TestMeScreenState extends State<TestMeScreen> {
  Future<List<Topic>> _topicList;
  int _topics = 0;

  @override
  void initState() {
    super.initState();
    _updateTopicList();
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
            subtitle: Text(topic.priority,
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
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.menu_book_outlined),
        label: const Text(
          'TEST!',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        onPressed: () async {
          if (_topics == 0) {
            final _snackBar = SnackBar(
              content: Text(
                  AppLocalizations.of(context).testme_screen_snackbar_text),
              padding: EdgeInsets.all(5.0),
              duration: Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(_snackBar);
          } else {
            var dialogTopic;
            List<Topic> currentTopicList = await _topicList;
            currentTopicList.shuffle();
            for (var i = 0; i < currentTopicList.length; i++) {
              if (currentTopicList[i].status == 0) {
                dialogTopic = currentTopicList[i];
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: SizedBox(),
                      content: Text(
                        dialogTopic.title,
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            'OK',
                            style: TextStyle(
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w900),
                          ),
                          onPressed: () {
                            dialogTopic.status = 1;
                            DatabaseHelper.instance.updateTopic(dialogTopic);
                            _updateTopicList();
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ));
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 9.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
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
                            title: SizedBox(),
                            content: Text(
                              AppLocalizations.of(context)
                                  .testme_screen_confirm_delete,
                              style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w900,
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
                            color: Colors.black,
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
                      )
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
}
