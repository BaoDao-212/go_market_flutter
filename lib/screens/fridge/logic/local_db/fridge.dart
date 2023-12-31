import 'dart:async';
import 'package:path/path.dart';
import 'package:shop_app/screens/fridge/logic/models/member.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseFood {
  static const String tableName = 'fridges';

  static Future<Database> openDatabaseFood() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'fridge_database.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY,
            name TEXT,
            categoryName TEXT,
            unitName TEXT,
            imageUrl TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<void> insertFood(Food fridge) async {
    final Database db = await openDatabaseFood();
    await db.insert(
      tableName,
      {
        'id': fridge.id,
        'name': fridge.name,
        'categoryName': fridge.categoryName,
        'unitName': fridge.unitName,
        'imageUrl': fridge.imageUrl,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteAllFoods() async {
    final Database db = await openDatabaseFood();
    await db.delete(tableName);
  }

  static Future<List<Food>> getFoods() async {
    final Database db = await openDatabaseFood();
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return Food(
        id: maps[i]['id'],
        name: maps[i]['name'],
        categoryName: maps[i]['categoryName'],
        unitName: maps[i]['unitName'],
        imageUrl: maps[i]['imageUrl'],
      );
    });
  }
}
