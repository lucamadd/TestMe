import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_me/models/topic_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  DatabaseHelper._instance();

  String topicTable = 'topic_table';
  String colId = 'id';
  String colTitle = 'title';
  String colPriority = 'priority';
  String colStatus = 'status';

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'testme.db';
    final testmeDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return testmeDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $topicTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colPriority TEXT, $colStatus INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getTopicMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(topicTable);
    return result;
  }

  Future<List<Topic>> getTopicList() async {
    final List<Map<String, dynamic>> topicMapList = await getTopicMapList();
    final List<Topic> topicList = [];
    topicMapList.forEach((topicMap) {
      topicList.add(Topic.fromMap(topicMap));
    });
    return topicList;
  }

  Future<int> insertTopic(Topic topic) async {
    Database db = await this.db;
    final int result = await db.insert(topicTable, topic.toMap());
    return result;
  }

  Future<int> updateTopic(Topic topic) async {
    Database db = await this.db;
    final int result = await db.update(topicTable, topic.toMap(),
        where: '$colId = ?', whereArgs: [topic.id]);
    return result;
  }

  Future<int> deleteTask(int id) async {
    Database db = await this.db;
    final int result =
        await db.delete(topicTable, where: '$colId = ?', whereArgs: [id]);
    return result;
  }

  Future<int> deleteAllTasks() async {
    Database db = await this.db;
    final int result = await db.delete(topicTable);
    return result;
  }
}
