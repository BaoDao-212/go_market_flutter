import 'dart:async';
import 'package:path/path.dart';
import 'package:shop_app/screens/notification/logic/models/member.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class DatabaseNotification {
  static const String tableName = 'notificationss';

  static Future<Database> openDatabaseNotification() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notifications_database.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            body INTEGER,
            date TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<void> insertNotification(Notification notification) async {
    final Database db = await openDatabaseNotification();
    print(123);
    await db.insert(
      tableName,
      {
        'body': notification.body,
        'title': notification.title,
        'date': notification.date,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteAllNotifications() async {
    final Database db = await openDatabaseNotification();
    await db.delete(tableName);
  }

  static Future<List<Notification>> getNotifications() async {
    print(1);
    final Database db = await openDatabaseNotification();
    print(1);
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    print(maps);
    return List.generate(maps.length, (i) {
      return Notification(
        id: maps[i]['id'],
        body: maps[i]['body'],
        title: maps[i]['title'],
        date: maps[i]['date'],
      );
    });
  }
}
