import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_me/ad_manager.dart';
import 'package:test_me/helpers/database_helper.dart';
import 'package:test_me/models/topic_model.dart';

class AddRowScreen extends StatefulWidget {
  final Function updateTopicList;

  final Topic topic;

  AddRowScreen({this.updateTopicList, this.topic});

  @override
  _AddRowScreenState createState() => _AddRowScreenState();
}

class _AddRowScreenState extends State<AddRowScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _priority;
  String _notes;

  List<String> _priorities = [];
  // TODO: Add _bannerAd
  BannerAd _bannerAd;

  // TODO: Add _isBannerAdReady
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    if (widget.topic != null) {
      _title = widget.topic.title;
      _priority = widget.topic.priority;
      _notes = widget.topic.notes;
    }
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId2,
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

  _delete() {
    DatabaseHelper.instance.deleteTask(widget.topic.id);
    widget.updateTopicList();
    Navigator.pop(context);
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('$_title, $_priority, $_notes');

      Topic topic = Topic(title: _title, priority: _priority, notes: _notes);
      if (widget.topic == null) {
        //insert task into DB
        topic.status = 0;
        DatabaseHelper.instance.insertTopic(topic);
      } else {
        //update the task
        topic.id = widget.topic.id;
        topic.status = widget.topic.status;
        DatabaseHelper.instance.updateTopic(topic);
      }
      widget.updateTopicList();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _priorities = [
      AppLocalizations.of(context).add_row_priorities_1,
      AppLocalizations.of(context).add_row_priorities_2,
      AppLocalizations.of(context).add_row_priorities_3
    ];
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30.0,
                  color: Color(0xff5e65f3),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                widget.topic == null
                    ? AppLocalizations.of(context).add_row_main_title
                    : AppLocalizations.of(context).add_row_main_title2,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Manrope',
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 10.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: TextFormField(
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)
                                .add_row_text_title_placeholder,
                            labelStyle: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w600,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: (input) => input.trim().isEmpty
                            ? AppLocalizations.of(context)
                                .add_row_text_title_error
                            : null,
                        onSaved: (input) => _title = input,
                        initialValue: _title,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: DropdownButtonFormField(
                        isDense: true,
                        icon: Icon(Icons.arrow_drop_down_circle),
                        iconSize: 22.0,
                        iconEnabledColor: Color(0xff5e65f3),
                        items: _priorities.map((String priority) {
                          return DropdownMenuItem(
                              value: priority,
                              child: Text(
                                priority,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Manrope',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                              ));
                        }).toList(),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)
                                .add_row_text_priority_placeholder,
                            labelStyle: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w600,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: (input) => _priority == null
                            ? AppLocalizations.of(context)
                                .add_row_text_priority_error
                            : null,
                        onChanged: (value) {
                          setState(() {
                            _priority = value;
                          });
                        },
                        value: _priority,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: TextFormField(
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)
                                .add_row_text_page_placeholder,
                            labelStyle: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w600,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        onSaved: (input) => _notes = input,
                        initialValue: _notes,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 60.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff858df8), Color(0xff5e65f3)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: TextButton(
                        onPressed: _submit,
                        child: Text(
                            widget.topic == null
                                ? AppLocalizations.of(context)
                                    .add_row_button_add
                                : AppLocalizations.of(context)
                                    .add_row_button_update,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w800,
                                fontSize: 20.0)),
                      ),
                    ),
                    widget.topic != null
                        ? Container(
                            margin: EdgeInsets.symmetric(vertical: 20.0),
                            height: 60.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: TextButton(
                              onPressed: _delete,
                              child: Text(
                                  AppLocalizations.of(context)
                                      .add_row_button_delete,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20.0)),
                            ),
                          )
                        : SizedBox
                            .shrink(), // TODO: Display a banner when ready
                    if (_isBannerAdReady)
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: _bannerAd.size.width.toDouble(),
                          height: _bannerAd.size.height.toDouble(),
                          child: AdWidget(ad: _bannerAd),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();
    super.dispose();
  }
}
