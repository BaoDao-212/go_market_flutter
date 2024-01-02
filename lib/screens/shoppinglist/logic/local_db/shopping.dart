import 'dart:async';
import 'package:path/path.dart';
import 'package:shop_app/screens/shopping/logic/bloc/bloc.dart';
import 'package:shop_app/screens/shopping/logic/models/member.dart';
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
            quantity INTEGER,
            note TEXT,
            type TEXT,
            imageUrl TEXT,
            expiredDate TEXT,
            startDate TEXT
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
        'quantity': shopping.quantity,
        'type': shopping.type,
        'startDate':
            DateFormat('yyyy-MM-dd hh:mm:ss').format(shopping.startDate),
        'expiredDate':
            DateFormat('yyyy-MM-dd hh:mm:ss').format(shopping.expiredDate),
        'imageUrl': shopping.imageUrl,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteAllShoppings() async {
    final Database db = await openDatabaseShopping();
    await db.delete(tableName);
  }

  static Future<List<Shopping>> getShoppings() async {
    final Database db = await openDatabaseShopping();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    print(maps);
    return List.generate(maps.length, (i) {
      return Shopping(
        id: maps[i]['id'],
        name: maps[i]['name'],
        note: maps[i]['note'],
        quantity: maps[i]['quantity'],
        type: maps[i]['type'],
        startDate: DateTime.parse(maps[i]['startDate']),
        expiredDate: DateTime.parse(maps[i]['expiredDate']),
        imageUrl: maps[i]['imageUrl'],
      );
    });
  }
}
