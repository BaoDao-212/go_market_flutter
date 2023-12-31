import 'dart:async';
import 'package:path/path.dart';
import 'package:shop_app/screens/food/logic/models/member.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseFood {
  static const String tableName = 'foods';

  static Future<Database> openDatabaseFood() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'food_database.db');

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

  static Future<void> insertFood(Food food) async {
    final Database db = await openDatabaseFood();
    await db.insert(
      tableName,
      {
        'id': food.id,
        'name': food.name,
        'categoryName': food.categoryName,
        'unitName': food.unitName,
        'imageUrl': food.imageUrl,
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
