import 'dart:async';
import 'package:path/path.dart';
import 'package:shop_app/screens/shoppinglist/logic/models/member.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class DatabaseShopping {
  static const String tableName = 'shoppings';

  static Future<Database> openDatabaseShopping() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'shopping_database.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY,
            name TEXT,
            note TEXT,
            username TEXT,
            assignedToUserId INTERGER,
            belongsToGroupAdminId INTERGER,
            date TEXT,
            tasks TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<void> insertShopping(Shopping shopping) async {
    final Database db = await openDatabaseShopping();
    await db.insert(
      tableName,
      {
        'id': shopping.id,
        'name': shopping.name,
        'note': shopping.note,
        'username': shopping.username,
        'tasks': shopping.tasks.toString(),
        'assignedToUserId': 1,
        'belongsToGroupAdminId': 1,
        'date': DateFormat('yyyy-MM-dd hh:mm:ss').format(shopping.date),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteAllShoppings() async {
    final Database db = await openDatabaseShopping();
    await db.delete(tableName);
  }

  static Future<List<Shopping>> getShoppings() async {
    print(0);
    final Database db = await openDatabaseShopping();
    print(db);
    final List<Map<String, dynamic>> maps = await db.query("shoppings");
    print(maps);
    return List.generate(maps.length, (i) {
      return Shopping(
        id: maps[i]['id'],
        name: maps[i]['name'],
        note: maps[i]['note'],
        tasks: (maps[i]['tasks']),
        username: (maps[i]['username']),
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }
}
